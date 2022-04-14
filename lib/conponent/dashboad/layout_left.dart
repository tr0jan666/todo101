import 'package:flutter/material.dart';
import 'package:todo101/conponent/dashboad/widget/item_widget.dart';
import 'package:todo101/share/app_bar.dart';

class LayoutLeft extends StatefulWidget {
  const LayoutLeft({Key? key}) : super(key: key);

  @override
  _LayoutLeftState createState() => _LayoutLeftState();
}

class _LayoutLeftState extends State<LayoutLeft> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
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
