import 'package:flutter/material.dart';
import 'package:notes_app/models/NotesOperation.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotesOperation>(
      create: (context)=> NotesOperation(),
      child: MaterialApp(
        darkTheme: ThemeData.dark(),

        theme:ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.blue[900],
          backgroundColor: Colors.white,
          // Define the default font family.
          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.

        ),
        home:HomeScreen(),
      ),
    );
  }
}
