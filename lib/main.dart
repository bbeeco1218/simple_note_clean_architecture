import 'package:flutter/material.dart';
import 'package:simple_note_clean_architecture/presentation/note_home/note_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: NoteHome(),
    );
  }
}
