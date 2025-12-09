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
      ///<<<<<<<<<<<this is  app bar design>>>>>>>>>>>
   appBar: AppBar(

     title: Center(child: Text("Notes")

     ),
    // backgroundColor: Colors.greenAccent,
   ),


      ///<<<<<<<<<<<<<< add floatingactionbutton>>>>>>>>>>>>>

      floatingActionButton: FloatingActionButton(
        child:  Icon(Icons.add),
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
          itemBuilder: (context, index) {
            final note = controller.notes[index];
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