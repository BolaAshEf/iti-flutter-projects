import 'package:dummy_projects/notes_app/note_card_model.dart';
import 'package:dummy_projects/notes_app/note_manager.dart';
import 'package:dummy_projects/proj2/login_page.dart';
import 'package:dummy_projects/proj4/login_page2.dart';
import 'package:flutter/material.dart';
import 'notes_app/db_manager.dart';
import 'notes_app/notes_home_screen.dart';

void main() async {
  await DBManager.initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark, 
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return NotesAppHomeScreen(key: homeScreenGK,);
  }
}
