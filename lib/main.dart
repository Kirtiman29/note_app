

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Screens/note_screen.dart';

void main(){
  runApp(NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
      home: const NoteScreen(),
    );
  }
}
