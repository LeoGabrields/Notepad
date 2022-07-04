import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notepad/provider/note_provider.dart';
import 'package:notepad/screens/note_screen.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';

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
      create: (context) => NoteProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        routes: {
          'NoteScreen': (context) => const NoteScreen(),
          '/': (context) => const HomeScreen()
        },
      ),
    );
  }
}
