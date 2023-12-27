import 'package:flutter/material.dart';
import 'package:note_app/constant/customappbar.dart';
import 'package:note_app/views/widgets/listNotes.dart';

class NoteViewBody extends StatelessWidget {
  const NoteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: const EdgeInsets.all(12.0),
          child: CustomAppbar(),
        ),
        Expanded(child: ListNotes()),
      ],
    );
  }
}
