import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:note_shelf/src/model/note.dart';
import 'package:note_shelf/src/services/local_db.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({super.key});

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  final _titleControlller = TextEditingController();
  final _discriptionController = TextEditingController();
  final localDb = LocalDBService();

  @override
  void dispose() {
    super.dispose();

    log(_titleControlller.text);
    log(_discriptionController.text);

    final title = _titleControlller.text;
    final discription = _discriptionController.text;

    final newNote = Note(
        id: Isar.autoIncrement,
        title: title,
        discription: discription,
        lastMod: DateTime.now());

    localDb.saveNote(note: newNote);

    _titleControlller.dispose();
    _discriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _titleControlller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                ),
                style: GoogleFonts.poppins(
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _discriptionController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "discription",
                ),
                style: GoogleFonts.poppins(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
