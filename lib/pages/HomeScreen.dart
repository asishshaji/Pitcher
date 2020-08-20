import 'package:Pitcher/components/CustomIconCardScroll.dart';
import 'package:Pitcher/components/HomeHeader.dart';
import 'package:Pitcher/data/model/user.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  HomeScreen({Key key, this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeader(
              imageUrl: widget.user.imageUrl, userName: widget.user.username),
          CustomIconCardScroll(),
        ],
      )),
    );
  }
}
