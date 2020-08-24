import 'package:Pitcher/components/CustomIconCardScroll.dart';
import 'package:Pitcher/components/HomeHeader.dart';
import 'package:Pitcher/data/model/bookPost.dart';
import 'package:Pitcher/data/model/user.dart';
import 'package:Pitcher/data/user_firestore_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';
import 'package:time_formatter/time_formatter.dart';

class HomeScreen extends StatefulWidget {
  final PitcherUser user;

  HomeScreen({Key key, this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, int>> postLikes = List();
  bool upvoted = false, downvoted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            FirebaseFirestore f = FirebaseFirestore.instance;
            f.collection("path").doc("SD").set({"as": 1});
          },
          label: Text("Click")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(
                imageUrl: widget.user.imageUrl, userName: widget.user.username),
            CustomIconCardScroll(),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: DatabaseServices().getBookPosts(),
              builder: (context, snap) {
                // print("Inside StreamBuilder ${snap.data}");
                if (snap.hasData &&
                    snap.connectionState == ConnectionState.active) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snap.data.length,
                    itemBuilder: (context, index) {
                      BookPost bookPost = snap.data[index];
                      return Card(
                        elevation: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              subtitle: Text(
                                formatTime(bookPost.timestamp),
                                style: GoogleFonts.dmSans(),
                              ),
                              title: Text(
                                bookPost.userId,
                                style: GoogleFonts.dmSans(),
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  bookPost.imageUrl,
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      bookPost.book.bookImageUrl,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        bookPost.book.bookTitle,
                                        style: GoogleFonts.dmSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        bookPost.book.author,
                                        style: GoogleFonts.dmSans(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        bookPost.book.publishedYear.toString(),
                                        style: GoogleFonts.dmSans(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Genres",
                                        style: GoogleFonts.dmSans(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: new Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: bookPost.genres
                                              .toList()
                                              .map(
                                                (item) => new Text(
                                                  item.toString().toUpperCase(),
                                                  style: GoogleFonts.dmSans(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Mdi.arrowUp,
                                    ),
                                    onPressed: () async {
                                      await DatabaseServices().upvotePost(
                                        bookPost.timestamp.toString(),
                                        bookPost.votes,
                                      );
                                    }),
                                Text(
                                  bookPost.votes.toString(),
                                  style: GoogleFonts.dmSans(),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Mdi.arrowDown,
                                    ),
                                    onPressed: () async {
                                      await DatabaseServices().downvotePost(
                                        bookPost.timestamp.toString(),
                                        bookPost.votes,
                                      );
                                    }),
                              ],
                            ),
                            ExpansionTile(
                              childrenPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 12,
                              ),
                              title: Text(
                                "Read review",
                                style: GoogleFonts.dmSans(
                                  fontSize: 16,
                                ),
                              ),
                              children: [
                                Text(
                                  bookPost.summaryByUser,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
