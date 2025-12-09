import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaleup_interview_task_03/presentation/controller/notes_controller.dart' show NotesController;
import 'package:scaleup_interview_task_03/presentation/screens/notes_list_screeen.dart';
import 'data/local_storage/shared_pref_helper.dart';
import 'data/repositories/note_repository_impl.dart';


void main() {
  final repo = NoteRepositoryImpl(sharedPrefHelper: SharedPrefHelper());
  final controller = NotesController(repository: repo);

  runApp(MyApp(controller));
}

class MyApp extends StatelessWidget {
  final NotesController controller;

  const MyApp(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesListScreen(controller: controller),
    );
  }
}