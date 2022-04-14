import 'package:flutter/material.dart';

PreferredSizeWidget appBar(BuildContext context) => AppBar(
      toolbarHeight: 80,
      leading: const Icon(
        Icons.people_alt_outlined,
        size: 30,
      ),
      title: Text(
        "Groceries",
        style: Theme.of(context).textTheme.bodyText1?.copyWith(height: 32, color: Colors.white),
      ),
    );
