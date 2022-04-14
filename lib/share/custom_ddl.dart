import 'package:flutter/material.dart';

class CustomDrodownList extends StatefulWidget {
  const CustomDrodownList({Key? key}) : super(key: key);

  @override
  _CustomDrodownListState createState() => _CustomDrodownListState();
}

class _CustomDrodownListState extends State<CustomDrodownList> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      icon: const Icon(Icons.light_mode_rounded),
      elevation: 16,
      style: Theme.of(context).textTheme.titleLarge,
      underline: Container(),
      onChanged: (String? newValue) {},
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: SizedBox(
              width: MediaQuery.of(context).size.width / 8, child: Text(value)),
        );
      }).toList(),
    );
  }
}
