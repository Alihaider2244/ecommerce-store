import 'package:flutter/material.dart';

class TopTitles extends StatelessWidget {
  final title, subtitle;
  const TopTitles({super.key,required this.title,required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(subtitle),
      ],
    );
  }
}
