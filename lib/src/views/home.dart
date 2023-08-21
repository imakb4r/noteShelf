import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_shelf/src/model/note.dart';
import 'package:note_shelf/src/res/appStrings.dart';
import 'package:note_shelf/src/services/local_db.dart';
import 'package:note_shelf/src/views/widgets/create_note.dart';
import 'package:note_shelf/src/views/widgets/emptyview.dart';

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
            //EmpptyView(),

            StreamBuilder<List<Note>>(
                stream: LocalDBService().listenAllNotes(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return EmpptyView();
                  }
                  final notes = snapshot.data;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: notes!.length,
                        itemBuilder: (context, index) {
                          return Text("${notes[index].title}");
                        }),
                  );
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CreateNoteView()));
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.green,
        ),
      ),
    );
  }
}
