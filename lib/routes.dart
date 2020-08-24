import 'package:Pitcher/pages/HomeScreen.dart';
import 'package:Pitcher/pages/SearchScreen.dart';
import 'package:Pitcher/pages/books/AddSummaryToBook.dart';
import 'package:Pitcher/pages/books/BookAdd.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case "/addNewBook":
        return MaterialPageRoute(builder: (_) => AddNewBookScreen());
      case "/search":
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case "/addSummaryBook":
        return MaterialPageRoute(
          builder: (_) => AddSummaryToBook(
            book: args["book"],
            ref: args["id"],
          ),
        );
    }
    return MaterialPageRoute(builder: (_) => HomeScreen());
  }
}
