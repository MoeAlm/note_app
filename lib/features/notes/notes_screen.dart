import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/notes/note_cubit/note_cubit.dart';
import 'package:note_app/features/notes/read_notes.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../core/constants.dart';
import '../../core/model/note_model.dart';
import 'add_note.dart';
import 'note_cubit/note_state.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<NoteCubit, NoteState>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var cubit = NoteCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('الملاحظات'),
          ),
          body: cubit.notesList.isNotEmpty
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 0.0,
                  ),
                  itemCount: cubit.notesList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return ReadNotes(
                                model: cubit.notesList[index],
                                index: index,
                              );
                            }),
                          );
                        },
                        onLongPress: () {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                title: const Text('تنبيه'),
                                content: const Text(
                                    'هل انت متأكد من انك تريد حذف الملاحظة؟'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('لا'),
                                    onPressed: () {
                                      Navigator.of(dialogContext)
                                          .pop(); // Dismiss alert dialog
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('نعم'),
                                    onPressed: () {
                                      cubit.deleteNote(index);
                                      Navigator.of(dialogContext)
                                          .pop(); // Dismiss alert dialog
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: defaultNorteCard(theme, cubit.notesList[index]));
                  })
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/notes.png',
                    ).opacity25(),
                  ],
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AddNote();
              }));
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget defaultNorteCard(ThemeData theme, Note model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: model.color,
          borderRadius: BorderRadius.circular(kRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.title,
              style: theme.textTheme.titleLarge,
            ),
            Text(
              model.content,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Text(model.createdDate)
          ],
        ),
      ),
    );
  }
}
