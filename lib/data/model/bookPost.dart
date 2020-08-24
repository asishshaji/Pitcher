import 'dart:convert';

import 'package:Pitcher/data/model/book.dart';

class BookPost {
  final String bookId;
  final String userId;
  final String summaryByUser;
  final String imageUrl;
  final int timestamp;
  final Book book;
  final int votes;
  final Set genres;
  final Map<String, int> userVoteMap;

  BookPost({
    this.bookId,
    this.userId,
    this.summaryByUser,
    this.imageUrl,
    this.timestamp,
    this.book,
    this.votes = 0,
    this.userVoteMap,
    this.genres,
  });

  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId,
      'userId': userId,
      'summaryByUser': summaryByUser,
      'imageUrl': imageUrl,
      'timestamp': timestamp,
      'book': book?.toMap(),
      'votes': votes,
      'userVoteMap': userVoteMap,
      'genres': genres.toList(),
    };
  }

  factory BookPost.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return BookPost(
      bookId: map['bookId'],
      userId: map['userId'],
      summaryByUser: map['summaryByUser'],
      imageUrl: map['imageUrl'],
      timestamp: map['timestamp'],
      book: Book.fromMap(map['book']),
      votes: map['votes'],
      userVoteMap: map['userVoteMap'] == null
          ? {"": 0}
          : Map<String, int>.from(map['userVoteMap']),
      genres: Set.from(map['genres']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookPost.fromJson(String source) =>
      BookPost.fromMap(json.decode(source));
}
