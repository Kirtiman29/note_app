

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final Map<String, dynamic> note;
  final Function onDelete;
  final Function onTap;
  final List<Color> noteColors;



  const NoteCard({
    super.key,
    required this.note,
    required this.onDelete,
    required this.onTap,
    required this.noteColors,
  });

  @override
  Widget build(BuildContext context) {

    final colorIndex = note['color'] as int;
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: noteColors[colorIndex],
          borderRadius: BorderRadius.circular(20),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note['date'],
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 8,),

            Text(
              note['title'],
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,

            ),

            const SizedBox(height: 8,),


          ],
        ),
      ),
    );
  }
}
