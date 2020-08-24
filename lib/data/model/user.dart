import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PitcherUser extends Equatable {
  final String userid;
  final String username;
  final String upiId;
  final String phoneNumber;
  final String location;
  final String imageUrl;
  final Set interests;

  // set containing document references of posts by users
  final Set bookPosts;
  final String timeStamp;

  PitcherUser({
    @required this.userid,
    @required this.username,
    @required this.timeStamp,
    this.upiId,
    this.phoneNumber,
    this.location,
    this.imageUrl,
    this.interests,
    this.bookPosts,
  });

  @override
  List<Object> get props {
    return [
      userid,
      username,
      upiId,
      phoneNumber,
      location,
      imageUrl,
      interests,
      bookPosts,
      timeStamp,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'username': username,
      'upiId': upiId,
      'phoneNumber': phoneNumber,
      'location': location,
      'imageUrl': imageUrl,
      'interests': interests,
      'bookPosts': bookPosts,
      'timeStamp': timeStamp,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;
}
