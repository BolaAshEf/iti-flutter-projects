import 'package:dummy_projects/notes_app/db_manager.dart';
import 'package:dummy_projects/notes_app/note_manager.dart';
import 'package:flutter/material.dart';

import 'notes_home_screen.dart';
import 'search_screen.dart';

class NoteModel{
  final int id;
  final String title;
  final String text;
  final Color color;
  const NoteModel({
    required this.id,
    required this.title,
    required this.text,
    required this.color,
  });

  NoteModel.fromJson(Map<String, dynamic> json) : 
    id = json["id"],
    title = json["title"],
    text = json["text"],
    color = Color(json["clrInt"]);

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "text": text,
    "clrInt": color.value
  };
}

class NoteCard extends StatefulWidget {
  final NoteModel note;
  const NoteCard({
    super.key,
    required this.note,
  });

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  void _deleteNote() async {
    await DBManager.delete(widget.note);
    homeScreenGK.currentState?.setState(() {});
    searchScreenGK.currentState?.setState(() {});
  }

  void _viewNote() => Navigator.push(
    context, 
    MaterialPageRoute(builder: (context) => NoteManager.preview(note: widget.note),),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Dismissible(
        key: ValueKey(widget.note.id),
        direction: DismissDirection.startToEnd,
        onDismissed: (_) => _deleteNote(),
        background: Container(
          color: Colors.red,  
          alignment: Alignment.center,
          child: const Icon(Icons.delete, size: 43,),
        ),
        child: Material(
          color: widget.note.color,
          child: InkWell(
            onTap: _viewNote,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Text(
                widget.note.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 45,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}