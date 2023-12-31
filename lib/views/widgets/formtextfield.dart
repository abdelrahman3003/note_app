import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note_app/constant/CustomTextfield.dart';
import 'package:note_app/constant/constants.dart';
import 'package:note_app/cubits/add_note%20_cubit/add_note_cubit.dart';

import 'package:note_app/model/note_model.dart';
import 'package:note_app/views/widgets/colors_lisview.dart';
import 'package:note_app/views/widgets/customButton.dart';

class Formtextfield extends StatefulWidget {
  const Formtextfield({super.key});

  @override
  State<Formtextfield> createState() => _FormtextfieldState();
}

class _FormtextfieldState extends State<Formtextfield> {
  final GlobalKey<FormState> formsate = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? title, subtitle;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formsate,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomTextfield(
              hintText: "Title",
              onSaved: (v) {
                title = v;
              },
              maxLines: 1,
            ),
            const SizedBox(
              height: 12,
            ),
            CustomTextfield(
              hintText: "Content",
              onSaved: (v) {
                subtitle = v;
              },
              maxLines: 4,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 38 * 2,
              child: ColorLisView(),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomButtom(
                    backgroundcolor: kprimarycolor,
                    textcolor: Colors.black,
                    text: "Add",
                    onPressed: () {
                      onpressed(context);
                    })),
          ],
        ),
      ),
    );
  }

  void onpressed(BuildContext context) {
    if (formsate.currentState!.validate()) {
      formsate.currentState!.save();
      NoteModel note = NoteModel(
          title: title!,
          subtitle: subtitle!,
          date: DateFormat("dd-mm-yyyy").format(DateTime.now()),
          color: BlocProvider.of<AddNoteCubit>(context).color.value);

      BlocProvider.of<AddNoteCubit>(context).addnote(note);
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }
}
