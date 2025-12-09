import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../local_storage/shared_pref_helper.dart';



class NoteRepositoryImpl implements NoteRepository {
  final SharedPrefHelper sharedPrefHelper;

  NoteRepositoryImpl({required this.sharedPrefHelper});

  @override
  Future<void> addNote(Note note) async {
    await sharedPrefHelper.saveNote(note);
    await syncNoteToAPI(note);
  }

  @override
  Future<void> updateNote(Note note) async {
    await sharedPrefHelper.updateNote(note);
    await syncNoteToAPI(note);
  }

  @override
  Future<void> deleteNote(String id) async {
    await sharedPrefHelper.deleteNote(id);
  }

  @override
  Future<List<Note>> getNotes() async {
    return await sharedPrefHelper.getAllNotes();
  }

  @override
  Future<void> syncNoteToAPI(Note note) async {
    try {
      await http.post(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        body: jsonEncode(note.toMap()),
        headers: {"Content-Type": "application/json"},
      );
    } catch (e) {

    }
  }
}