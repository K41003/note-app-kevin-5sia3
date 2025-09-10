import 'package:flutter/material.dart';
import 'package:nore_app/notes/notes_screen.dart';

class UpdateNoteScreen extends StatefulWidget {
  const UpdateNoteScreen({super.key});

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context, MaterialPageRoute(
                builder: (context) => NotesScreen()
              )
            );
          }, 
          icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          )
        ),
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
        title: const Text("Update Note",
        style: 
        TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Text('Halaman Note Screen'),
      ),
    );
  }
}