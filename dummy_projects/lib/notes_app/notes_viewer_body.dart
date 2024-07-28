import 'package:dummy_projects/notes_app/note_card_model.dart';
import 'package:flutter/material.dart';

class NotesViewer extends StatelessWidget {
  final List<NoteModel> notes;
  final ImageProvider noNotesImg;
  final String noNotesText;
  const NotesViewer({
    super.key,
    required this.notes,
    required this.noNotesImg,
    required this.noNotesText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150,),
        child: notes.isEmpty 
          ? Center(
            key: const ValueKey("no-results"),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image(image: noNotesImg),
                  Text(noNotesText),
                ],
              ),
            )
          : SizedBox.expand(
            key: const ValueKey("results"),
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    for(final note in notes) NoteCard(
                      note: note,
                    ),
                  ],
                ),
              ),
          ),
      ),
    );
  }
}