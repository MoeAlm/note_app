import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note_app/core/model/note_model.dart';
import 'package:note_app/features/notes/note_cubit/note_cubit.dart';
import 'package:velocity_x/velocity_x.dart';

import 'note_cubit/note_state.dart';
class EditNote extends StatelessWidget {
  final int index;
  const EditNote(Note model, {super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    Size size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    return BlocConsumer<NoteCubit, NoteState>(
      listener: (BuildContext context, NoteState state) {},
      builder: (BuildContext context, NoteState state) {
        var cubit = NoteCubit.get(context);
        return Form(
          key: cubit.formKey,
          child: Scaffold(
            appBar: AppBar(),
            body: ListView(
              children: [
                Text('عدل ملاحظتك', style: theme.textTheme.headlineSmall)
                    .py20(),
                TextFormField(
                  maxLines: 1,
                  controller: cubit.titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'هذا الحقل مطلوب';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'العنوان',
                    hintText: 'اكتب عنوانا يناسب ملاحظتك..',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                TextFormField(
                  maxLines: 5,
                  controller: cubit.contentController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'هذا الحقل مطلوب';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'النص',
                    hintText: 'اكتب نصا..',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ).py20(),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: size.width * 0.6,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.updateNote(
                            Note(
                                title: cubit.titleController.text,
                                content: cubit.contentController.text,
                                createdDate: DateFormat.yMMMd().format(date),
                                color: cubit.colors[cubit.selectedIndex]), index
                          );
                          cubit.titleController.clear();
                          cubit.contentController.clear();
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('تعديل'),
                    ),
                  ),
                ).py12()
              ],
            ).px12(),
          ),
        );
      },
    );
  }
}
