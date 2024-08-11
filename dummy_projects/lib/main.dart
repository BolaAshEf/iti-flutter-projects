import 'package:dummy_projects/notes_app/note_card_model.dart';
import 'package:dummy_projects/notes_app/note_manager.dart';
import 'package:dummy_projects/proj2/login_page.dart';
import 'package:dummy_projects/proj4/login_page2.dart';
import 'package:flutter/material.dart';
import 'notes_app/db_manager.dart';
import 'notes_app/notes_home_screen.dart';
import 'proj1/text_field_eye.dart';
import 'proj6/api_example.dart';

void main() async {
  //await DBManager.initDB();
  runApp(const MultiPassApp());
}

