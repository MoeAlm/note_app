import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/model/note_model.dart';
import 'note_state.dart';


class NoteCubit extends Cubit<NoteState>{
  NoteCubit() : super(InitialState());
  static NoteCubit get(context) => BlocProvider.of(context);


  Database? dataBase;
  GlobalKey<FormState> formKey = GlobalKey();
  List<Note> notesList = [];
  int selectedIndex = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  List<Color> colors = [
    Colors.redAccent,
    Colors.yellowAccent,
    Colors.deepOrangeAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.purpleAccent,
  ];

  void addNote(Note note){
    notesList.add(note);
    emit(AddNoteState());
  }
  void updateNote(Note note, index){
    notesList[index] = note;
    emit(AddNoteState());
  }



  void changeIndex(index){
    selectedIndex = index;
    emit(UpdateNoteState());
  }
  void deleteNote(index){
     notesList.removeAt(index);
    emit(DeletedNoteState());
  }

  void createDatabase() {
    openDatabase('note.db', version: 1, onCreate: (dateBase, version) {
      print('dataBase is created');
      dateBase
          .execute(
          'CREATE TABLE note(id INTEGER PRIMARY KEY, title TEXT, date DATETIME)')
          .then((value) {
        print('Table created');
      }).catchError((error) {
        print('Error happened when creating ${error.toString()}');
      });
    }, onOpen: (dataBase) {
      getDataFromDatabase(dataBase);
      print('dataBase is opened');
    }).then((value) {
      dataBase = value;
      emit(CreateNoteState());
    });
  }

  insertToDatabase({
    required String title,
    required String content,
    required String date,
  }) async {
    await dataBase!.transaction((txn) {
      return txn
          .rawInsert(
          'INSERT INTO note(title, date, time) VALUES("$title","$date","$content")')
          .then((value) {
        print('$value inserted successfully');
        emit(AddNoteState());
        getDataFromDatabase(dataBase);
      }).catchError((error) {
        print('Error when Inserting New Record ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(dataBase) async {
    emit(GetNoteState());
    dataBase?.rawQuery('SELECT * FROM note').then((value) {
      value.forEach((element) {

        notesList.add(element);
      });
      emit(GetNoteState());
    });
  }

  void updateData({required String status, required int id}) async {
    dataBase?.rawUpdate(
        'UPDATE note SET status = ? WHERE id = ?', [status, id]).then((value) {
      getDataFromDatabase(dataBase);
      emit(UpdateNoteState());
    });
  }
  void deleteData({required int id}) async {
    dataBase?.rawDelete(
        'DELETE FROM note WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(dataBase);
      emit(DeletedNoteState());
    });
  }

}