import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.title,
      this.isFullWidthButton,
      this.disable,
      this.onPressed})
      : super(key: key);
  final String title;
  final bool? isFullWidthButton;
  final bool? disable;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    if (isFullWidthButton != null && isFullWidthButton!) {
      return Row(
        children: [Expanded(child: _elevatedButton(context))],
      );
    }
    return _elevatedButton(context);
  }

  ElevatedButton _elevatedButton(BuildContext context) {
    return ElevatedButton(
        clipBehavior: Clip.antiAlias,
        onPressed: onPressed,
        child: Container(margin: const EdgeInsets.all(16), child: _text()));
  }

  Text _text() => Text(
        title,
        textAlign: TextAlign.center,
      );
}
