import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/note.dart';


///<<<<<<<<<<<<<<<<< SharedPrefHelper>>>>>>>>>>>>
class SharedPrefHelper {
  static const String notesKey = "notes";

  Future<void> saveNote(Note note) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notes = prefs.getStringList(notesKey) ?? [];
    notes.add(jsonEncode(note.toMap()));
    await prefs.setStringList(notesKey, notes);
  }

  Future<void> updateNote(Note note) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notes = prefs.getStringList(notesKey) ?? [];
    notes = notes.map((e) {
      final map = jsonDecode(e);
      if (map['id'] == note.id) return jsonEncode(note.toMap());
      return e;
    }).toList();
    await prefs.setStringList(notesKey, notes);
  }

  Future<void> deleteNote(String id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notes = prefs.getStringList(notesKey) ?? [];
    notes.removeWhere((e) => jsonDecode(e)['id'] == id);
    await prefs.setStringList(notesKey, notes);
  }

  Future<List<Note>> getAllNotes() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notes = prefs.getStringList(notesKey) ?? [];
    return notes.map((e) => Note.fromMap(jsonDecode(e))).toList();
  }
}