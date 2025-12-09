import 'package:get/get.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';

class NotesController extends GetxController {
  final NoteRepository repository;


  RxList<Note> notes = <Note>[].obs;


  NotesController({required this.repository});

  @override
  void onInit() {
    loadNotes();
    super.onInit();
  }

  void loadNotes() async {
    notes.value = await repository.getNotes();
  }


  void addNote(Note note) async {
    await repository.addNote(note);
    notes.add(note);
  }


  void updateNote(Note note) async {
    await repository.updateNote(note);
    int index = notes.indexWhere((e) => e.id == note.id);
    if (index != -1) {
      notes[index] = note;
      notes.refresh(); // refresh UI
    }
  }


  void deleteNote(String id) async {
    await repository.deleteNote(id);
    notes.removeWhere((e) => e.id == id);
  }
}