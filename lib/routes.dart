import 'package:Pitcher/pages/HomeScreen.dart';
import 'package:Pitcher/pages/LoginScreen.dart';
import 'package:Pitcher/pages/SearchScreen.dart';
import 'package:Pitcher/pages/books/BookAdd.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case "/addNewBook":
        return MaterialPageRoute(builder: (_) => AddNewBookScreen());
      case "/search":
        return MaterialPageRoute(builder: (_) => SearchScreen());
    }
  }
}
