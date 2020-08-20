import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
    @required this.imageUrl,
    this.userName,
  }) : super(key: key);

  final String userName;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              imageUrl,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "Hey, ${userName}",
            style: GoogleFonts.dmSans(
              fontSize: 26,
            ),
          )
        ],
      ),
    );
  }
}
