class Book {
  final String bookTitle;
  final String bookImageUrl;
  final String author;
  final int publishedYear;
  final Set tags;
  Book({
    this.bookTitle,
    this.author,
    this.bookImageUrl,
    this.publishedYear,
    this.tags,
  });

  Map<String, dynamic> toMap() {
    return {
      'bookTitle': bookTitle,
      'author': author,
      'bookImageUrl': bookImageUrl,
      'publishedYear': publishedYear,
      'tags': tags.toList(),
    };
  }
}
