import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notepad/controller/note_controller.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'pages/note_page.dart';


main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ChangeNotifierProvider(
      create: (context) => NoteController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        routes: {
          'NoteScreen': (context) => const NotePage(),
          '/': (context) => const HomePages()
        },
      ),
    );
  }
}
