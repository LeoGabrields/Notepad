import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:notepad/data/db_sql.dart';
import 'package:notepad/models/note_model.dart';

class NoteProvider with ChangeNotifier {
  List<NoteModel> _noteList = [];
  List<NoteModel> filterList = [];

  void search(String text) async {
    if (text.isEmpty) {
      filterList = _noteList;
    } else {
      filterList = _noteList.where((item) {
        return item.title.toLowerCase().contains(
              text.toLowerCase(),
            );
      }).toList();
    }
    notifyListeners();
  }

  void loadNotes() async {
    final dataList = await DbSql.getData('note');

    _noteList = dataList
        .map((item) => NoteModel(
            id: item['id'],
            title: item['title'],
            content: item['content'],
            date: item['date']))
        .toList();
    filterList = _noteList;
    notifyListeners();
  }

  void saveNote(Map<String, dynamic> data) async {
    bool hasId = data['id'] != null;

    final note = NoteModel(
      id: hasId ? data['id'] : Random().nextDouble().toString(),
      title: data['title'],
      content: data['content'],
      date: DateFormat('MMM d, yyyy h:mm a').format(DateTime.now()),
    );

    DbSql.insert('note', {
      'id': note.id,
      'title': note.title,
      'content': note.content,
      'date': note.date
    });

    if (hasId) {
      updateNote(note);
    } else {
      addNote(note);
    }
    notifyListeners();
  }

  void addNote(NoteModel note) {
    _noteList.add(note);
    notifyListeners();
  }

  void updateNote(NoteModel note) {
    int index = _noteList.indexWhere((n) => n.id == note.id);
    if (index >= 0) {
      _noteList[index] = note;
      notifyListeners();
    }
  }

  void removeNote(NoteModel note) {
    DbSql.delete(note.id);
    int index = filterList.indexWhere((n) => n.id == note.id);

    if (index >= 0) {
      filterList.removeWhere((n) => n.id == note.id);
      _noteList.removeWhere((n) => n.id == note.id);
      notifyListeners();
    }
  }
}
