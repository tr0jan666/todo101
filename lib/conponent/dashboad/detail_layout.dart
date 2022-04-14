import 'package:flutter/material.dart';
import 'package:todo101/conponent/dashboad/widget/item_widget.dart';
import 'package:todo101/share/custom_ddl.dart';

class DetailLayout extends StatefulWidget {
  final Function()? iconTopAction;
  const DetailLayout({Key? key, this.iconTopAction}) : super(key: key);

  @override
  _DetailLayoutState createState() => _DetailLayoutState();
}

class _DetailLayoutState extends State<DetailLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [_buildTop(context), _buildListItem()],
        ),
      ),
    );
  }

  Widget _buildTop(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      height: 80,
      child: Row(
        children: [
          const Expanded(flex: 1, child: Text("TODO APP")),
          const CustomDrodownList(),
          SizedBox(
              width: 56,
              child: IconButton(
                  onPressed: widget.iconTopAction,
                  icon: const Icon(
                    Icons.more_horiz_outlined,
                    size: 32,
                  )))
        ],
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
