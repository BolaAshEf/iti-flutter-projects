import 'package:dummy_projects/notes_app/db_manager.dart';
import 'package:dummy_projects/notes_app/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'app_bar_button.dart';
import 'note_card_model.dart';
import 'note_manager.dart';
import 'notes_viewer_body.dart';

final homeScreenGK = GlobalKey();

class NotesAppHomeScreen extends StatefulWidget {
  const NotesAppHomeScreen({super.key});

  @override
  State<NotesAppHomeScreen> createState() => _NotesAppHomeScreenState();
}

class _NotesAppHomeScreenState extends State<NotesAppHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        toolbarHeight: 100,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 43,
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: AppBarButton(
              icon: Icons.search,
              onPressed: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => SearchScreen(
                  key: searchScreenGK,
                ),),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox.square(
        dimension: 70,
        child: FloatingActionButton(
          onPressed: () => Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => const NoteManager.add(),),
          ),
          backgroundColor: Colors.black,
          elevation: 10,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: 48,),
        ),
      ),
      body: NotesViewer(
        notes: DBManager.notes.values.toList(),
        noNotesImg: const AssetImage("images/no-notes.png"),
        noNotesText: "Create your first note !",
      ),
    );
  }
}
