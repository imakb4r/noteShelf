import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_shelf/src/model/note.dart';
import 'package:note_shelf/src/res/appStrings.dart';
import 'package:note_shelf/src/services/local_db.dart';
import 'package:note_shelf/src/views/widgets/create_note.dart';
import 'package:note_shelf/src/views/widgets/emptyview.dart';
import 'package:note_shelf/src/views/widgets/note_list.dart';
import 'package:note_shelf/src/views/widgets/notes_grid.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isListView = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.appName,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isListView = !isListView;
                      });
                    },
                    icon: Icon(
                      isListView ? Icons.splitscreen_outlined : Icons.grid_view,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Note>>(
                  stream: LocalDBService().listenAllNotes(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const EmpptyView();
                    }
                    final notes = snapshot.data!;

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: isListView
                          ? NoteList(notes: notes)
                          : NotesGrid(notes: notes),
                    );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CreateNoteView()));
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.green,
        ),
      ),
    );
  }
}
