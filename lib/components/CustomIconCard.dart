import 'package:flutter/material.dart';

class CustomIconCard extends StatelessWidget {
  const CustomIconCard({
    Key key,
    this.iconData,
    this.onClick,
  }) : super(key: key);

  final IconData iconData;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 4,
      ),
      width: 80,
      child: Card(
        elevation: 2,
        child: IconButton(
          icon: Icon(iconData),
          color: Colors.grey.shade800,
          onPressed: onClick,
        ),
      ),
    );
  }
}
