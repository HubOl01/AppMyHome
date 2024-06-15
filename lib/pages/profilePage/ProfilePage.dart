import 'dart:convert';
import 'package:MyAppHome/pages/profilePage/SOSPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../core/Styles/Colors.dart';
import '../Login/LoginPage.dart';
import '../chatsPages/Chats/api/firebase.dart';
import '/ProfileCom/personalPage.dart';
import '../CallPages/CallPage.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as pathProvider;

import '../contactingPage/SendInEmail.dart';
import '../../core/Utils/UserPerefer.dart';
import '../../components/ButtonLoginPage.dart';
import '../../components/ButtonWidget.dart';
import '../../components/ButtonWidgetProfile.dart';
import '../../components/WidgetProfile.dart';
import 'EditProfilePage.dart';

class ProfileePage extends StatefulWidget {
  final user;
  const ProfileePage({required this.user});
  @override
  State<ProfileePage> createState() => _ProfileePageState();
}

class _ProfileePageState extends State<ProfileePage> {
  @override
  void initState() {
    super.initState();
    baseAPI.readAvatar();
    // getAvatar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(child: buildProfilewidget(widget.user)),
    );
  }

  Widget buildProfilewidget(var user) {
    setState(() {});
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          
          child: Stack(
            children: [
              // Image.asset(
              //     'assets/profile/profileBackground.jpg', width: size.width,
              //     fit: BoxFit.fill),
              Image.asset(
                  'assets/profile/GroundUpBar.png',  width: size.width,
                  fit: BoxFit.fill),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              
                child: Stack(
              children: [
                WidgetProfileName(
                  user: user,
                ),
              ],
            )),
            SizedBox(height: size.height / 8),
            //Button
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
              child: Container(
                height: 40,
                width: size.width,
                child: buildPersonalBillButton(),
              ),
            ),
            ////
            const Spacer(),
            Container(
              margin: EdgeInsets.all(30),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: build_UK_Button()),
                  SizedBox(width: 30),
                  Expanded(child: build_Problem_Button()),
                  SizedBox(width: 30),
                  Expanded(child: build_worker_Button())
                ],
              ),
            ),
            const Spacer(),
            ////
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Container(
                  height: 40,
                  width: size.width,
                  child: build_Setting_Button(),
                )),
            SizedBox(height: 10),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Container(
                  height: 40,
                  width: size.width,
                  child: buildExitProfileButton(),
                )),
          ],
        )
      ],
    );
  }

  Widget buildExitProfileButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            // onPrimary: Colors.black,
            backgroundColor: Colors.red[600]),
        onPressed: () {
          runApp(LoginPage());
        },
        child: Stack(
          children: [
            Text('Выход', style: TextStyle(fontSize: 21, color: Colors.white)),
          ],
        ),
      );
  // ButtonWidget(
  //   text:'Выход',
  //   onClicked: (){
  //       runApp(LoginPage());
  //     // Navigator.of(context).push(
  //         // MaterialPageRoute(builder: (context) => LoginPage())
  //       // );
  //     },
  //   );

  Widget buildEditProfileButton() => ButtonWidget(
        text: 'Редактировать',
        onClicked: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EditProfilePage()));
        },
      );

  Widget buildPersonalBillButton() => ButtonWidget(
        text: 'Лицевой Счёт',
        onClicked: () async {
          final directory = await pathProvider.getApplicationSupportDirectory();
          final fileDirectory = directory.path + '/datasTest.json';
          final file = File(fileDirectory);
          final json = jsonDecode(await file.readAsString());
          UsersedTest nikita = UsersedTest.fromJson(json['user']);

          Clipboard.setData(new ClipboardData(text: nikita.personalCheck))
              .then((_) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(nikita.personalCheck)));
          });
        },
      );
  ////
  Widget build_UK_Button() => ButtonWidgetProfile(
        title: "УК",
        imagees: "assets/icons/message.svg",
        onClicked: () {
          Get.to(Send());
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => Send()));
        },
      );

  Widget build_Problem_Button() => ButtonWidgetProfile(
        title: "",
        imagees: "assets/icons/sos.svg",
        onClicked: () {
          Get.to(SOSPage());
        },
      );

  Widget build_worker_Button() => ButtonWidgetProfile(
        title: "Службы",
        imagees: "assets/icons/call.svg",
        onClicked: () {
          ButtonLoginReg();
          Get.to(CallPage());
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => CallPage()));
        },
      );

  Widget build_Setting_Button() => ButtonWidget(
        text: 'Настройки',
        onClicked: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EditProfilePage()));
        },
      );
}
