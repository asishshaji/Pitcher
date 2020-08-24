import 'package:Pitcher/data/firebase_auth_repo.dart';
import 'package:Pitcher/data/model/book.dart';
import 'package:Pitcher/data/model/bookPost.dart';
import 'package:Pitcher/data/model/user.dart';
import 'package:Pitcher/data/user_firestore_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';

class AddSummaryToBook extends StatefulWidget {
  final Book book;
  final String ref;

  const AddSummaryToBook({Key key, this.book, this.ref}) : super(key: key);

  @override
  _AddSummaryToBookState createState() => _AddSummaryToBookState();
}

class _AddSummaryToBookState extends State<AddSummaryToBook> {
  BookPost bookPost;
  final summaryController = TextEditingController();

  @override
  void dispose() {
    summaryController.dispose();
    super.dispose();
  }

  List<String> genres = [
    "action and adventure",
    "classics",
    "comics",
    "fiction",
    "fantasy",
    "horror",
    "romance",
    "sci-fi",
    "thriller",
    "Autobiographies",
    "Poetry",
    "selfhelp"
  ];
  Set selectedGenres = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String summary = summaryController.text;

            PitcherUser user = await AuthRepo().getUser();
            if (summary.length != 0) {
              int timestamp = DateTime.now().millisecondsSinceEpoch;
              BookPost bookPost = BookPost(
                bookId: widget.ref,
                userId: user.userid,
                summaryByUser: summary,
                imageUrl: user.imageUrl,
                timestamp: timestamp,
                book: widget.book,
                userVoteMap: {"ASDS": 0},
                genres: selectedGenres,
              );
              DocumentReference ref =
                  await DatabaseServices().addBookPost(bookPost, timestamp);
              if (ref != null) {
                return Navigator.pushNamed(context, "/");
              }
            }
          },
          child: Icon(
            Mdi.upload,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildHeader(),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Tell us what you feel about\n${widget.book.bookTitle.toUpperCase()}",
                  style: GoogleFonts.dmSans(fontSize: 22),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Select genre",
                  style: GoogleFonts.dmSans(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.only(
                  top: 12,
                  bottom: 12,
                ),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: genres
                      .map((e) => InkWell(
                            onTap: () {
                              if (selectedGenres.contains(e))
                                selectedGenres.remove(e);
                              else
                                selectedGenres.add(e);
                              setState(() {});
                            },
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn,
                              margin: const EdgeInsets.only(
                                right: 5,
                              ),
                              decoration: BoxDecoration(
                                color: selectedGenres.contains(e)
                                    ? Colors.blue[900]
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    e.toUpperCase(),
                                    style: GoogleFonts.dmSans(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLines: 8,
                  minLines: null,
                  controller: summaryController,
                  decoration: InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      labelText: 'Summary',
                      labelStyle: GoogleFonts.dmSans()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          width: 150,
          child: Card(
            elevation: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                widget.book.bookImageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.book.bookTitle,
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.book.author,
                style: GoogleFonts.dmSans(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.book.publishedYear.toString(),
                style: GoogleFonts.dmSans(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
