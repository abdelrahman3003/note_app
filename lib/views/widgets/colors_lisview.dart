import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/constant/constants.dart';
import 'package:note_app/cubits/add_note%20_cubit/add_note_cubit.dart';

class ColorLisView extends StatefulWidget {
  const ColorLisView({super.key});

  @override
  State<ColorLisView> createState() => _ColorLisViewState();
}

class _ColorLisViewState extends State<ColorLisView> {
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: colors.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    currentindex = index;
                    BlocProvider.of<AddNoteCubit>(context).color =
                        colors[index];
                  });
                },
                child: currentindex == index
                    ? CircleAvatar(
                        radius: 38,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 36,
                          backgroundColor: colors[index],
                        ),
                      )
                    : CircleAvatar(
                        radius: 38,
                        backgroundColor: colors[index],
                      )));
      },
    );
  }
}
