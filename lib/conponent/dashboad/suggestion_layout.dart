import 'package:flutter/material.dart';

import 'widget/item_widget.dart';

class SugeetionLayout extends StatefulWidget {
  const SugeetionLayout({Key? key, this.onBack}) : super(key: key);
  final Function()? onBack;
  @override
  _LayoutLeftState createState() => _LayoutLeftState();
}

class _LayoutLeftState extends State<SugeetionLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 56, actions: [
        IconButton(
            onPressed: widget.onBack,
            icon: const Icon(
              Icons.close,
              size: 36,
            ))
      ]),
      body: Container(
        padding: const EdgeInsets.only(left: 16),
        height: MediaQuery.of(context).size.height,
        child: _buildListItem(),
      ),
    );
  }

  _buildListItem() => ListView.builder(
      itemCount: 6,
      shrinkWrap: true,
      itemBuilder: (context, index) => ItemTopicWidget(
            title: "ToDo Custom + $index",
          ));
}
