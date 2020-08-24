import 'package:Pitcher/data/model/book.dart';
import 'package:Pitcher/data/user_firestore_repo.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addNewBook');
        },
        child: Icon(
          Mdi.plus,
        ),
        backgroundColor: Colors.blue[400],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchBar(
            hintText: "Search",
            hintStyle: GoogleFonts.dmSans(),
            onSearch: DatabaseServices().searchBooks,
            onItemFound: (Book book, int index) {
              return ListTile(
                onTap: () => Navigator.pushNamed(context, '/addSummaryBook',
                    arguments: {"book": book, "id": book.ref}),
                title: Text(
                  book.bookTitle,
                  style: GoogleFonts.dmSans(),
                ),
                subtitle: Text(
                  book.author,
                  style: GoogleFonts.dmSans(),
                ),
                leading: Image.network(
                  book.bookImageUrl ??
                      "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
