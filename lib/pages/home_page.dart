import 'package:flutter/material.dart';
import 'package:notepad/controller/note_controller.dart';
import 'package:provider/provider.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteController>(context, listen: false).loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteController>(context);

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Notepad',
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 15,
                left: 15,
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10, bottom: 25),
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                      onChanged: (value) => noteProvider.search(value),
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search notes',
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: noteProvider.filterList.length,
                      itemBuilder: (ctx, index) {
                        final note =
                            noteProvider.filterList.reversed.toList()[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              onDismissed: (_) {
                                noteProvider.removeNote(note);
                              },
                              background: Container(
                                padding: const EdgeInsets.all(15),
                                alignment: Alignment.centerRight,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.red,
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .pushNamed('NoteScreen', arguments: note),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.10,
                                  width: double.infinity,
                                  color: Colors.grey[200],
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 15,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          note.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          note.date,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xff3f2ef4),
            onPressed: () {
              Navigator.of(context).pushNamed('NoteScreen');
            },
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
