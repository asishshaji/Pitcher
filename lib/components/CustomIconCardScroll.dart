import 'package:Pitcher/components/CustomIconCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';

class CustomIconCardScroll extends StatelessWidget {
  const CustomIconCardScroll({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            "Post something",
            textAlign: TextAlign.start,
            style: GoogleFonts.dmSans(
                textStyle: TextStyle(
              fontSize: 26,
            )),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              CustomIconCard(
                iconData: Mdi.bookshelf,
                onClick: () => Navigator.of(context).pushNamed("/addNewBook"),
              ),
              CustomIconCard(
                iconData: Mdi.musicBox,
                onClick: () => Navigator.of(context).pushNamed("/search"),
              ),
              CustomIconCard(
                iconData: Mdi.movie,
                onClick: () => Navigator.of(context).pushNamed("/search"),
              ),
              CustomIconCard(
                iconData: Mdi.youtube,
              ),
              CustomIconCard(
                iconData: Mdi.playlistMusic,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
