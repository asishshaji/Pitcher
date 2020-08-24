import 'dart:io';

import 'package:Pitcher/data/model/book.dart';
import 'package:Pitcher/data/model/bookPost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'model/user.dart';

class DatabaseServices {
  final CollectionReference bookRef =
      FirebaseFirestore.instance.collection('books');
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference bookPostRef =
      FirebaseFirestore.instance.collection('book_post');

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<bool> addUser(PitcherUser user) async {
    DocumentReference userRef = firestore.collection('users').doc(user.userid);
    userRef.set(user.toMap());
    if (userRef != null) return true;
    return false;
  }

  Future<void> updateUser(PitcherUser user) async {
    usersRef.doc(user.userid)..update(user.toMap());
  }

  Future<String> uploadImage(String bucket, File _image) async {
    var imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference storageReference =
        storage.ref().child("$bucket/$imageFileName");
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    String url = await storageReference.getDownloadURL().then((url) {
      return url;
    });
    return url;
  }

  void votes(String type, String postId, int currentVote) async {
    User user = FirebaseAuth.instance.currentUser;
    DocumentReference bookPostDoc = bookPostRef.doc(postId);
    print(bookPostDoc.snapshots());

    Map<String, int> userVoteMap = await bookPostRef
        .doc(postId)
        .get()
        .then((value) => BookPost.fromMap(value.data()).userVoteMap);
    String userName = user.email.toString();
    if (type == 'upvote') {
      if (userVoteMap.containsKey(userName)) {
        if (userVoteMap[userName] < 4) {
          userVoteMap[userName] += 1;
          bookPostDoc.update({
            "votes": currentVote + 1,
            "userVoteMap": userVoteMap,
          });
        }
      } else {
        userVoteMap[userName] = 1;
        bookPostDoc.update({
          "userVoteMap": userVoteMap,
          "votes": currentVote + 1,
        });
      }
    } else {
      if (userVoteMap.containsKey(userName)) {
        if (userVoteMap[userName] > -4) {
          userVoteMap[userName] -= 1;
          bookPostDoc.update({
            "votes": currentVote - 1,
            "userVoteMap": userVoteMap,
          });
        }
      } else {
        userVoteMap[userName] = 1;
        bookPostDoc.update({
          "userVoteMap": userVoteMap,
          "votes": currentVote + 1,
        });
      }
    }
  }

  Future<bool> upvotePost(String postId, int currentVote) async {
    votes("upvote", postId, currentVote);
    return true;
  }

  Future<bool> downvotePost(String postId, int currentVote) async {
    votes("downvote", postId, currentVote);

    return true;
  }

  Future<DocumentReference> addBook(Book book) async {
    DocumentReference ref = await bookRef.add(book.toMap());
    print("Pressed ${book.toJson()}");
    print("REF IS ${ref}");
    if (ref != null) return ref;
    return null;
  }

  Future<List<Book>> searchBooks(String search) async {
    QuerySnapshot querySnapshot =
        await bookRef.where('tags', arrayContains: search.toLowerCase()).get();
    List<Book> books = List();
    querySnapshot.docs.forEach((element) {
      books.add(Book.fromMap(element.data(), element.id));
    });
    return books;
  }

  Stream<List<BookPost>> getBookPosts() {
    return bookPostRef.snapshots().map((snapShot) => snapShot.docs.reversed
        .toList()
        .map((document) => BookPost.fromMap(document.data()))
        .toList());
  }

  Future<List<Book>> getBooksByGenre() async {
    List<Book> books = List();
    return books;
  }

  Future<DocumentReference> addBookPost(
      BookPost bookPost, int timestamp) async {
    DocumentReference ref = bookPostRef.doc(timestamp.toString())
      ..set(bookPost.toMap());

    List<String> bookPosts = List();
    bookPosts.add(ref.id.toString());
    usersRef.doc(bookPost.userId).update(
      {"bookPosts": FieldValue.arrayUnion(bookPosts)},
    );
    return ref;
  }
}
