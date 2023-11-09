import 'package:flutter/material.dart';
import 'package:simple_note_clean_architecture/presentation/note_home/screen/note_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NoteHomeScreen(),
    );
  }
}
