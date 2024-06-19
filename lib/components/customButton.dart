import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/Styles/Colors.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final bool isOutline;
  final bool isDelete;
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.isOutline = false,
      this.isDelete = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: context.width,
      height: 50,
      child: isOutline
          ? TextButton(
              onPressed: onPressed,
              child: Text(
                title,
                style: TextStyle(fontSize: 16),
              ),
              style: ButtonStyle(
                padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 60, vertical: 10)),
                // backgroundColor: WidgetStatePropertyAll(purpleColor),
                foregroundColor: WidgetStatePropertyAll(purpleColor),
                // primary: purpleColor,
                elevation: const WidgetStatePropertyAll(0),
                // onPrimary: Colors.cyan,
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                )),
              ),
            )
          : ElevatedButton(
              child: Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                side: isDelete ? BorderSide(
                  color: Colors.red,
                  width: 2
                ) : BorderSide.none,
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                backgroundColor: isDelete ? Colors.white : purpleColor,
                foregroundColor:isDelete ? Colors.red :  Colors.white,
                disabledBackgroundColor: purpleColor.withOpacity(.4),
                disabledForegroundColor: Colors.white,
                
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
    );
  }
}
