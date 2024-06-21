import 'package:MyAppHome/core/Data/SOSData.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/Styles/Colors.dart';

class SOSPage extends StatelessWidget {
  const SOSPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        title: Text("Экстренные службы"),
      ),
      body: ListView.builder(
          itemCount: sosList.length,
          itemBuilder: (context, index) => ListTile(
            contentPadding: EdgeInsets.only( left: 10, right: 0, ),
                title:
                    Text(sosList[index].title, style: TextStyle(fontSize: 18)),
                onTap: () async {
                  launchUrl(Uri.parse('tel:${sosList[index].tel}'));
                },
                trailing: ElevatedButton(
                  child: Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    launchUrl(Uri.parse('tel:${sosList[index].tel}'));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purpleColor,
                    shape: const CircleBorder(),
                  ),
                ),
              )),
    );
  }
}
