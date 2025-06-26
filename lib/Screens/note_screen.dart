import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Screens/note_dialog.dart';
import 'package:note_app/database/notes_database.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    final fetchNote = await NotesDatabse.instance.getNotes();

    setState(() {
      notes = fetchNote;
    });
  }

  final List<Color> noteColors = [
    const Color(0xFFF3E5F5), // Light Purple
    const Color(0xFFFFF3E0), // Light Orange
    const Color(0xFFE0F3FB), // Light Blue
    const Color(0xFF89CFF0), // Sky Blue
    const Color(0xFFF3E5F5), // Light Purple (repeated)
  ];

  void showNoteDialog({
    int? id,
    String? title,
    String? content,
    int colorIndex = 0,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return NoteDialog(
          colorIndex: colorIndex,
          noteColors: noteColors,

          noteId: id,
          title: title,
          content: content,
          onNoteSaved:
              (
                newTitle,
                newDescription,
                selectedColorIndex,
                currentDate,
              ) async {
                if (id == null) {
                  await NotesDatabse.instance.addNote(
                    newTitle,
                    newDescription,
                    currentDate,
                    selectedColorIndex,

                  );
                } else {
                  await NotesDatabse.instance.updateNote(
                    newTitle,
                    newDescription,
                    currentDate,
                    selectedColorIndex,
                    id,
                  );
                }
              },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Notes',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showNoteDialog();
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black87),
      ),

      body: notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.note_outlined, size: 80, color: Colors.grey[600]),
                  const SizedBox(height: 20),

                  Text(
                    'No Notes Found',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];

                  return Text(note['title']);
                },
              ),
            ),
    );
  }
}
