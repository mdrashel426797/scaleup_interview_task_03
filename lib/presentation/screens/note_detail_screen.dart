import 'package:flutter/material.dart';
import '../../domain/entities/note.dart';
import '../controller/notes_controller.dart' show NotesController;


class NoteDetailScreen extends StatefulWidget {
  final NotesController controller;
  final bool isEdit;
  final Note? existingNote;

  const NoteDetailScreen({
    super.key,
    required this.controller,
    required this.isEdit,
    this.existingNote,
  });

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController titleCtrl;
  late TextEditingController contentCtrl;
  String selectedColor = "0xFFFFFFFF";

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController(
      text: widget.existingNote?.title ?? "",
    );
    contentCtrl = TextEditingController(
      text: widget.existingNote?.content ?? "",
    );
    selectedColor = widget.existingNote?.colorTag ?? "0xFFFFFFFF";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      ///<<<<<<<<<<<<<<<<< logic app var >>>>>>>>>>>>>>>>
      appBar: AppBar(
        title: Text(widget.isEdit ? "Edit Note" : "Add Note"),
      ),


      /// <<<<<<<<<<<<<<<  state body >>>>>>>>>>>>>>>>
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [

            ///<<<<<<<<<<<<<<< tittle field>>>>>>>>>>>>>>>>
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(hintText: "Title"),
            ),
             SizedBox(height: 12),

            ///<<<<<<<<<<<<<this is content >>>>>>>>>>>>>>>>
            TextField(
              controller: contentCtrl,
              maxLines: 6,
              decoration: const InputDecoration(hintText: "Content"),
            ),



             SizedBox(height: 12),

            /// <<<<<<<<<<<<<< circle colors >>>>>>>>>>>>>

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                colorCircle("0xFFFFFFFF"),
                colorCircle("0xFFE57373"),
                colorCircle("0xFF81C784"),
                colorCircle("0xFF64B5F6"),
              ],
            ),

           SizedBox(height: 150,),

            ElevatedButton(
              onPressed: () {
                if (widget.isEdit) {
                  widget.controller.updateNote(
                    Note(
                      id: widget.existingNote!.id,
                      title: titleCtrl.text,
                      content: contentCtrl.text,
                      colorTag: selectedColor,
                    ),
                  );
                } else {
                  widget.controller.addNote(
                    Note(
                      id: DateTime.now().toString(),
                      title: titleCtrl.text,
                      content: contentCtrl.text,
                      colorTag: selectedColor,
                    ),
                  );
                }
                Navigator.pop(context);
              },
              child: const Text("Save Button"),

            ),
          ],
        ),
      ),
    );
  }

  Widget colorCircle(String color) {
    return GestureDetector(
      onTap: () {
        setState(() => selectedColor = color);
      },
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Color(int.parse(color)),
        child: selectedColor == color
            ? const Icon(Icons.check, size: 16, color: Colors.black)
            : null,
      ),
    );
  }
}