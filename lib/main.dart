import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:note_app/features/notes/note_cubit/note_cubit.dart';
import 'package:note_app/theme/custome_theme.dart';

import 'features/notes/notes_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteCubit>(create: (context) {
      return NoteCubit()..createDatabase();
    },
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note Keeper',
      theme: CustomTheme.darkTheme(context),
      themeMode: ThemeMode.dark,
      supportedLocales: const [
        Locale('ar'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const NotesScreen(),
    ),);
  }
}
