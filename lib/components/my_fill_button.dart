import 'package:flutter/material.dart';

class MyFillButton extends StatelessWidget {
  final String text;
  final double width;
  final void Function()? onTap;
  const MyFillButton({
    super.key,
    required this.text,
    this.width = 150.0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, 50),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      onPressed: onTap,
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
