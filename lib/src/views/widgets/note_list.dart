import 'package:flutter/material.dart';
import 'package:note_shelf/src/model/note.dart';
import 'package:auto_animated_list/auto_animated_list.dart';
import 'package:note_shelf/src/views/widgets/note_list_card.dart';

class NoteList extends StatelessWidget {
  const NoteList({super.key, required this.notes});

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return AutoAnimatedList<Note>(
      scrollDirection: Axis.vertical,
      //shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      items: notes,
      itemBuilder: (context, note, index, animation) {
        return SizeFadeTransition(
          animation: animation,
          child: NoteListCard(
            note: notes[index],
          ),
        );
      },
    );
  }
}
