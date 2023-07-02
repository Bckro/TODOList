import 'package:flutter/material.dart';
import 'package:todolist/screens/myhomepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO List',
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.blue,
        scaffoldBackgroundColor: Colors.lightBlue[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1A237E),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(
            color: Color(0xFF1A237E),
          ),
          labelStyle: TextStyle(
            color: Color(0xFF1A237E),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF1A237E),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF1A237E),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF1A237E),
          ),
        ),
        textTheme: Theme.of(context)
            .textTheme
            .apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
              fontSizeFactor: 1.2,
              fontFamily: 'Cambria',
            )
            .copyWith(
              headline6: TextStyle(
                color: Color(0xFF1A237E),
              ),
              subtitle1: TextStyle(
                color: Color(0xFF1A237E), // Zmiana koloru tekstu na czarny
              ),
            ),
      ),
      home: MyHomePage(),
    );
  }
}
