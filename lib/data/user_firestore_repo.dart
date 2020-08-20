import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Pitcher/data/model/book.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'model/user.dart';

class FireStoreActions {
  final CollectionReference bookRef = Firestore.instance.collection('books');
  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> addUser(User user) async {
    debugPrint("Adding ${user.username} to DB");
    DocumentReference userRef =
        firestore.collection('users').document(user.userid);
    userRef.setData(user.toMap());
  }

  Future<void> updateUser(User user) async {
    DocumentReference userRef =
        firestore.collection('users').document(user.userid);
    userRef.updateData(user.toMap());
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
    print(url);
    return url;
  }

  Future<bool> addBook(Book book) async {
    DocumentReference ref = await bookRef.add(book.toMap());
    if (ref != null) return true;
    return false;
  }

  Future<List<Book>> searchBooks(String search) async {
    QuerySnapshot querySnapshot = await bookRef
        .where('tags', arrayContains: search)
        .orderBy('')
        .limit(6)
        .getDocuments();
  }

  Future<List<Book>> getBooksByGenre() async {}
}
