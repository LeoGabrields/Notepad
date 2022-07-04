import 'package:flutter/material.dart';
import 'package:notepad/models/note_model.dart';
import 'package:provider/provider.dart';
import '../provider/note_provider.dart';


class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _dataMap = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_dataMap.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null) {
        final note = arg as NoteModel;
        _dataMap['id'] = note.id;
        _dataMap['title'] = note.title;
        _dataMap['content'] = note.content;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Note',
            style: TextStyle(
              color: Colors.black,
              fontSize: 21,
              fontWeight: FontWeight.w500,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {
                var isValid = _formKey.currentState?.validate() ?? false;
                if (!isValid) {
                  return;
                } else {
                  _formKey.currentState?.save();
                  noteProvider.saveNote(_dataMap);
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.check_sharp),
            ),
          ],
          iconTheme: const IconThemeData(color: Color(0xff3f2ef4), size: 30),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, top: 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        onSaved: (title) {
                          _dataMap['title'] = title!;
                        },
                        initialValue: _dataMap['title'],
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Title',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                        validator: (title) {
                          if (title!.trim().isEmpty) {
                            return 'Empty field!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        onSaved: (content) {
                          _dataMap['content'] = content!;
                        },
                        initialValue: _dataMap['content'],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Note something down',
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        autofocus: false,
                        validator: (content) {
                          if (content!.trim().isEmpty) {
                            return 'Empty field!';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
