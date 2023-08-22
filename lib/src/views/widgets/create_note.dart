import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:lottie/lottie.dart';
import 'package:note_shelf/src/model/note.dart';
import 'package:note_shelf/src/res/assets.dart';
import 'package:note_shelf/src/services/local_db.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({super.key, this.note});

  final Note? note;

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  final _titleControlller = TextEditingController();
  final _discriptionController = TextEditingController();
  final localDb = LocalDBService();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleControlller.text = widget.note!.title;
      _discriptionController.text = widget.note!.discription;
    }
  }

  @override
  void dispose() {
    super.dispose();

    log(_titleControlller.text);
    log(_discriptionController.text);

    final title = _titleControlller.text;
    final discription = _discriptionController.text;

    if (widget.note != null) {
      if (title.isEmpty && discription.isEmpty) {
        localDb.deleteNote(id: widget.note!.id);
      } else if (widget.note!.title != title ||
          widget.note!.discription != discription) {
        final newNote = widget.note!.copyWith(
          title: title,
          discription: discription,
        );
        localDb.saveNote(note: newNote);
      }
    } else {
      final newNote = Note(
          id: Isar.autoIncrement,
          title: title,
          discription: discription,
          lastMod: DateTime.now());

      localDb.saveNote(note: newNote);
    }
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  widget.note != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {
                              //show alert before deleteing
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Delete Note?",
                                        style: GoogleFonts.poppins(
                                          color: Colors.grey,
                                          fontSize: 20,
                                        ),
                                      ),
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Lottie.asset(AnimationsAssets.delete),
                                          Text(
                                            "This note will be deleted permanently.",
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                            ),
                                          )
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              localDb.deleteNote(
                                                  id: widget.note!.id);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: Text("Confirm")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Cancle")),
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _titleControlller,
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(
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
