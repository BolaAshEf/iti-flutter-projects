import 'dart:math';
import 'package:dummy_projects/notes_app/note_card_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const _notebackgroundColors = [
  Colors.white, // Classic white
  Color(0xFFF8F8F8), // Lighter grey with good contrast
  Color(0xFFE8E8E8), // Medium grey with good contrast
  Color(0xFFD8D8D8), // Darker grey with good contrast
  Colors.lightBlueAccent, // Bright blue (might need contrast check)
  Colors.tealAccent, // Turquoise (might need contrast check)
  Colors.greenAccent, // Light green (might need contrast check)
  Colors.yellowAccent, // Bright yellow (might need contrast check)
  Colors.orangeAccent, // Orange (might need contrast check)
  Colors.pinkAccent, // Pink (might need contrast check)
  Colors.purpleAccent, // Purple (might need contrast check)
];

abstract class DBManager{
  static late final Box _notesBox;
  static late final Map<int, NoteModel> notes;

  static Future<void> initDB() async {
    await Hive.initFlutter();
    _notesBox = await Hive.openBox('notesBox');

    final allNotes = _notesBox.values.map((json){
      final jsonMap = json as Map;

      return NoteModel.fromJson(jsonMap.map((k, v) => MapEntry(k as String, v)));
    }).toList();
    notes = {
      for(final note in allNotes)
        note.id : note,
    };
  }

  static Future<NoteModel?> add(NoteModel note) async {
    if(note.title.trim().isEmpty || note.text.trim().isEmpty){
      return null;
    }

    late int newNoteID;
    do{
      newNoteID = Random().nextInt(100000000);
    } while(_notesBox.containsKey(newNoteID));

    final newNote = NoteModel(
      id: newNoteID,
      title: note.title.trim(),
      text: note.text.trim(),
      color: _notebackgroundColors[Random().nextInt(_notebackgroundColors.length)],
    );
    
    await _notesBox.put(newNote.id, newNote.toJson());
    notes[newNote.id] = newNote;
    return newNote;
  }

  static Future<NoteModel?> update(NoteModel note) async {
    if(!_notesBox.containsKey(note.id) || note.title.trim().isEmpty || note.text.trim().isEmpty){
      return null;
    }

    final updatedNote = NoteModel(
      id: note.id,
      title: note.title.trim(),
      text: note.text.trim(),
      color: note.color,
    );
    
    await _notesBox.put(updatedNote.id, updatedNote.toJson());
    notes[updatedNote.id] = updatedNote;
    return updatedNote;
  }

  static Future<void> delete(NoteModel note) async {
    await _notesBox.delete(note.id);
    notes.remove(note.id);
  }
}