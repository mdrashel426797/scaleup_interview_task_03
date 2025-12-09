import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/notes_controller.dart' show NotesController;
import '../widgets/note_card.dart';
import 'note_detail_screen.dart';

class NotesListScreen extends StatelessWidget {
  final NotesController controller;

  const NotesListScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///<<<<<<<<<<<this is for app bar design>>>>>>>>>>>
      appBar: AppBar(title: const Text("Notes")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(() => NoteDetailScreen(
            controller: controller,
            isEdit: false,
          ));
        },
      ),
      body: Obx(
            () => ListView.builder(
          itemCount: controller.notes.length,
          itemBuilder: (_, i) {
            final note = controller.notes[i];
            return NoteCard(
              note: note,
              onTap: () {
                Get.to(() => NoteDetailScreen(
                  controller: controller,
                  isEdit: true,
                  existingNote: note,
                ));
              },
            );
          },
        ),
      ),
    );
  }
}