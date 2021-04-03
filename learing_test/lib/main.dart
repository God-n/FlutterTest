import 'package:flutter/material.dart';
import 'package:learing_test/course.dart';
import 'package:learing_test/index.dart';
import 'package:learing_test/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        'index': (context) => index(),
        '/': (context) => login(),
        'course': (context) => course(),
      },
    );
  }
}
