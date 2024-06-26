import 'package:MyAppHome/core/Styles/Colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),),
      // onPrimary: Colors.black,
      backgroundColor: purpleColor
    ),
      onPressed: onClicked,
      child: Stack(
      children: [
          Text(text, style: TextStyle(fontSize: 21, color: Colors.white)),
          ],
        ),
      );
  }