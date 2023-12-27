import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/notes/edit_notes.dart';
import 'package:note_app/features/notes/note_cubit/note_cubit.dart';
import 'package:note_app/features/notes/note_cubit/note_state.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../core/model/note_model.dart';

class ReadNotes extends StatelessWidget {
  final Note model;
  final int index;

  const ReadNotes({super.key, required this.model, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<NoteCubit, NoteState>(
      listener: (BuildContext context, NoteState state) {},
      builder: (BuildContext context, NoteState state) {
        var cubit = NoteCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  cubit.titleController.text = model.title;
                  cubit.contentController.text = model.content;
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return EditNote(
                      model,
                      index: index,
                    );
                  }));
                },
                icon: const Icon(Icons.edit),
              )
            ],
          ),
          body: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(model.title, style: theme.textTheme.headlineMedium),
                Text(
                  model.createdDate,
                  style:
                      theme.textTheme.titleLarge?.copyWith(color: Colors.grey),
                ),
                Text(model.content, style: theme.textTheme.headlineSmall)
              ],
            ).px12(),
          ),
        );
      },
    );
  }
}
