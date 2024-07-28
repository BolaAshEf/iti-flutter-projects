import 'package:dummy_projects/notes_app/db_manager.dart';
import 'package:flutter/material.dart';
import 'notes_viewer_body.dart';

final searchScreenGK = GlobalKey();

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _queryController = TextEditingController();

  @override
  void dispose() {
    _queryController.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 200,
        title: TextFormField(
          onChanged: (_) => setState(() {}),
          controller: _queryController,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xff3B3B3B),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30.0),
            ),
            hintText: "Search by the keyword...",
            hintStyle: const TextStyle(
              color: Color(0xffCCCCCC),
              fontSize: 20,
            ),
            suffixIcon: IconButton(
              onPressed: () => setState(() => _queryController.clear(),), 
              icon: const Icon(Icons.clear),
            ),
          ),
        ),
      ),
      body: NotesViewer(
        notes: _queryController.text.isEmpty ? [] : DBManager.notes.values.where((note) => 
          note.title.toLowerCase().contains(_queryController.text.toLowerCase()) 
          || note.text.toLowerCase().contains(_queryController.text.toLowerCase())
        ).toList(),
        noNotesImg: const AssetImage("images/no-search-results.png"),
        noNotesText: "File not found. Try searching again.",
      ),
    );
  }
}
