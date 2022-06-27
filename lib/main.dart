import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notepad/provider/note_provider.dart';
import 'package:notepad/screens/note_screen.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';

main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.white),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        home: const HomeScreen(),
        routes: {
          'NoteScreen' : (context) => const NoteScreen(),
        },
      ),
    );
  }
}
