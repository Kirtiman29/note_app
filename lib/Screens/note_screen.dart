import 'package:flutter/material.dart';
import 'package:note_app/Screens/note_card.dart';
import 'package:note_app/Screens/note_dialog.dart';
import 'package:note_app/database/notes_database.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  List<Map<String, dynamic>> notes = [];

  final List<Color> noteColors = [
    const Color(0xFFF3E5F5),
    const Color(0xFFFFF3E0),
    const Color(0xFFE0F3FB),
    const Color(0xFF89CFF0),
    const Color(0xFFF3E5F5),
  ];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    final fetchedNotes = await NotesDatabse.instance.getNotes();
    setState(() {
      notes = fetchedNotes;
    });
  }

  void showNoteDialog({
    int? id,
    String? title,
    String? content,
    int colorIndex = 0,
  }) {
    showDialog(
      context: context,
      builder: (_) => NoteDialog(
        noteId: id,
        title: title,
        content: content,
        colorIndex: colorIndex,
        noteColors: noteColors,
        onNoteSaved: (newTitle, newDescription, selectedColorIndex, currentDate) async {
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
          fetchNotes();
        },
      ),
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
        onPressed: showNoteDialog,
        backgroundColor: Colors.blueAccent, // ✨ better on dark background
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: notes.isEmpty
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
            itemCount: notes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              final note = notes[index];
              return NoteCard(
                note: note,
                noteColors: noteColors,
                onDelete: () async {
                  await NotesDatabse.instance.deleteNote(note['id']);
                  fetchNotes();
                },
                onTap: () => showNoteDialog(
                  id: note['id'],
                  title: note['title'],
                  content: note['description'],
                  colorIndex: note['color'],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
