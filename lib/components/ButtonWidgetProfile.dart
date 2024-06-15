import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonWidgetProfile extends StatelessWidget {
  final VoidCallback onClicked;
  // final IconData icon;
  final String imagees;
  final String title;

  const ButtonWidgetProfile({
    Key? key,
    // required this.icon,
    required this.onClicked,
    required this.imagees,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            // onPrimary: Colors.black,
            backgroundColor: title == "" ? Color(0xffEC1C24) : Colors.white),
        onPressed: onClicked,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 80,
                width: 100,
                child: SvgPicture.asset(
                  imagees,
                )),
            title == ""
                ? const SizedBox()
                : Text(title,
                    style: TextStyle(fontSize: 14, color: Colors.grey))
          ],
        ),
      );
  // child: Text(text));
}
