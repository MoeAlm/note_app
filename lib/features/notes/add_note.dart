import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note_app/core/model/note_model.dart';
import 'package:note_app/features/notes/note_cubit/note_cubit.dart';
import 'package:velocity_x/velocity_x.dart';

import 'note_cubit/note_state.dart';

class AddNote extends StatelessWidget {
  const AddNote({super.key});

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
                Text('اكتب ملاحظتك', style: theme.textTheme.headlineSmall)
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
                Text('اختر اللون', style: theme.textTheme.headlineSmall),
                SizedBox(
                  height: size.height * 0.06,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cubit.colors.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            cubit.changeIndex(index);
                          },
                          child: Container(
                            width: size.width * 0.09,
                            decoration: BoxDecoration(
                                color: cubit.colors[index],
                                shape: BoxShape.circle),
                            child: cubit.selectedIndex == index
                                ? const Icon(Icons.check)
                                : const SizedBox.shrink(),
                          ).px(4),
                        );
                      }),
                ),
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
                          // cubit.insertToDatabase(
                          //   title: cubit.titleController.text,
                          //   content: cubit.contentController.text,
                          //   date: DateFormat.yMMMd().format(date),
                          // );
                          cubit.addNote(
                            Note(
                                title: cubit.titleController.text,
                                content: cubit.contentController.text,
                                createdDate: DateFormat.yMMMd().format(date),
                                color: cubit.colors[cubit.selectedIndex]),
                          );
                          cubit.titleController.clear();
                          cubit.contentController.clear();
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('حفظ'),
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
