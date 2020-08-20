import 'package:Pitcher/data/model/book.dart';
import 'package:Pitcher/data/model/song.dart';

class Post {
  final String postId;
  final String userId;
  final String timestamp;
  final String likes;
  final String details;
  final List<String> imageUrls;
  final List<Book> books;
  final List<Song> songs;

  Post({
    this.postId,
    this.likes,
    this.details,
    this.imageUrls,
    this.userId,
    this.timestamp,
    this.books,
    this.songs,
  });
}
