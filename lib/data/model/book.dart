import 'dart:convert';

class Book {
  final String bookTitle;
  final String bookImageUrl;
  final String author;
  final int publishedYear;
  final Set tags;
  final String ref;
  Set genre;

  Book({
    this.bookTitle,
    this.author,
    this.bookImageUrl,
    this.publishedYear,
    this.tags,
    this.ref,
  });

  Map<String, dynamic> toMap() {
    return {
      'bookTitle': bookTitle,
      'bookImageUrl': bookImageUrl,
      'author': author,
      'publishedYear': publishedYear,
      'tags': tags?.toList(),
    };
  }

  factory Book.fromMap(Map<String, dynamic> map, [String ref]) {
    if (map == null) return null;

    return Book(
      bookTitle: map['bookTitle'],
      bookImageUrl: map['bookImageUrl'],
      author: map['author'],
      publishedYear: map['publishedYear'],
      tags: Set.from(map['tags']),
      ref: ref,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));
}
