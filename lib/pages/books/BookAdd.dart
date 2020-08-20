import 'dart:io';

import 'package:Pitcher/data/model/book.dart';
import 'package:Pitcher/data/user_firestore_repo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mdi/mdi.dart';

class AddNewBookScreen extends StatefulWidget {
  AddNewBookScreen({Key key}) : super(key: key);

  @override
  AddNewBookScreenState createState() => AddNewBookScreenState();
}

class AddNewBookScreenState extends State<AddNewBookScreen> {
  File _image;
  final picker = ImagePicker();

  String _bookName;
  int _year;
  String _imageUrl;
  String _author;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
    _imageUrl = await FireStoreActions().uploadImage("books", _image);
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _image == null
                        ? IconButton(
                            icon: Icon(
                              Mdi.upload,
                            ),
                            onPressed: getImage,
                          )
                        : Image.file(
                            _image,
                            height: 120,
                            width: 120,
                          ),
                  ),
                  Expanded(
                    child: Text(
                      "Fill in the details",
                      style: GoogleFonts.dmSans(
                        fontSize: 26,
                      ),
                    ),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Book name',
                        border: OutlineInputBorder(
                          gapPadding: 5,
                        ),
                        prefixIcon: Icon(
                          Mdi.book,
                        ),
                      ),
                      autovalidate: false,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      onSaved: (value) => this._bookName = value,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Author',
                        border: OutlineInputBorder(
                          gapPadding: 5,
                        ),
                        prefixIcon: Icon(
                          Mdi.book,
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      autovalidate: false,
                      onSaved: (value) => this._author = value,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Published year',
                        border: OutlineInputBorder(
                          gapPadding: 5,
                        ),
                        prefixIcon: Icon(
                          Mdi.book,
                        ),
                      ),
                      autovalidate: false,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      onSaved: (value) => this._year = int.parse(value),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      color: Colors.greenAccent,
                      child: Text(
                        "add book".toUpperCase(),
                        style: GoogleFonts.dmSans(),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Set tags = {};
                          tags.addAll([
                            ..._bookName.split(" "),
                            ..._author.split(" "),
                          ]);
                          Book book = Book(
                            author: _author,
                            bookImageUrl: _imageUrl,
                            bookTitle: _bookName,
                            publishedYear: _year,
                            tags: tags,
                          );
                          bool added = await FireStoreActions().addBook(book);
                          if (added) {
                            Navigator.pop(context);
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
