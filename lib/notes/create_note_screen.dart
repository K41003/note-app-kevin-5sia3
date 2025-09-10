import 'package:flutter/material.dart';
import 'package:nore_app/notes/notes_screen.dart';
import '../models/note_model.dart';
import '../database/database_helper.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final db = DatabaseHelper();

  Future<void> createNote() async {
    try {
      int result = await db.createNote(
        NoteModel(
          noteTitle: titleController.text,
          noteContent: noteController.text,
          createdAt: DateTime.now().toIso8601String(),
        )
      );


      if (!mounted) return;

      if (result > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Note created successfully'),
            backgroundColor: Colors.teal[400],
            behavior: SnackBarBehavior.floating,
          ),
        );

        // Navigate back to notes screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NotesScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to create note'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occured while createing note.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color: Colors.white,),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NotesScreen()
              )
            );
          },
        ),
        title: Text("Create Note",
        style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            onPressed: () {
              if(formkey.currentState!.validate()) {
                createNote();
              }
            },
        icon: const Icon(Icons.check,
        color: Colors.white,
        ),
          ),
        ],
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "Please enter title";
                  }
                  return null;
                },
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: noteController,
                decoration: InputDecoration(
                  hintText: "Note",
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "Please enter note";
                  }
                  return null;
                },
                style: TextStyle(
                  fontSize: 20,
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ],
          ),),
      )
    );
  }
}