import 'package:flutter/material.dart';
import '../core/Model/User.dart';

class WidgetProfileName extends StatelessWidget {
  final User user;
  const WidgetProfileName({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Align(
          alignment: Alignment.topLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    "https://cdn-icons-png.flaticon.com/512/1946/1946429.png"),
                foregroundImage: NetworkImage(user.imagePath),
                radius: 50,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(user.name,
                          style: TextStyle(fontSize: 30, color: Colors.white)),
                    ],
                  ),
                  Text(user.about,
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ],
              ),
            ],
          ),
        ));
  }
}
