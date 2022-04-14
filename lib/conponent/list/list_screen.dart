import 'package:flutter/material.dart';
import 'package:todo101/conponent/dashboad/widget/item_widget.dart';
import 'package:todo101/share/app_bar.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({ Key? key }) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: appBar(context) ,
      body: Container(
        padding: const EdgeInsets.all(16),
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