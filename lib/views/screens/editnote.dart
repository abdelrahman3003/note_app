import 'package:flutter/material.dart';
import 'package:note_app/model/note_model.dart';
import 'package:note_app/views/widgets/editnote_body.dart';

class EditNote extends StatelessWidget {
  const EditNote({super.key, required this.note});
  final NoteModel note;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditNoteBody(note: note),
    );
  }
}
