import 'package:flutter/material.dart';

class ItemTopicWidget extends StatelessWidget {
  final Function(dynamic)? onItemClick;
  final String title;
  const ItemTopicWidget({Key? key, this.onItemClick, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
      child: Card(
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              child: const Icon(Icons.person_pin),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
