import 'dart:convert';
import 'package:MyAppHome/components/customButton.dart';
import 'package:MyAppHome/components/customInput.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'dart:async';
import 'package:flutter/services.dart';
import '../../core/Utils/UserPerefer.dart';

class Send extends StatefulWidget {
  @override
  State<Send> createState() => _SendState();
}

class _SendState extends State<Send> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  String email = "";

  String name = "";

  TextEditingController subjectController = TextEditingController();

  TextEditingController messageController = TextEditingController();

  String subject = "";

  String message = "";

/////////////////
  funcPress() {
    void getUserTesta() async {
      final directory = await pathProvider.getApplicationSupportDirectory();
      final fileDirectory = directory.path + '/datasTest.json';
      final file = File(fileDirectory);
      final json = jsonDecode(await file.readAsString());

      print(json);
      UsersedTest nikita = UsersedTest.fromJson(json['user']);
      print("code = ${nikita.code}");
      print("email");

      Timer(Duration(milliseconds: 50), () {
        email = nikita.adminEmail;
        name = nikita.name;
        print("email");
        print(email);
      });
    }

    getUserTesta();
    print("Test");
    Timer(Duration(milliseconds: 100), () {
      subject = subjectController.text;
      message = messageController.text;

      sendEmail(subject: subject, message: message);
      subjectController.clear();
      messageController.clear();

      print(
          "name = $name | email = $email | subject = $subject | message = $message");
      print("object");

      if (email == "" || email == "no") {
        Fluttertoast.showToast(
            msg:
                "Отправка обращения невозможна, обратитесь к руководителю ТСЖ для добавления адреса получателя",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }
    });
  }

///////////////////
  // Widget _logButton() {
  //   return Container(
  //       margin: EdgeInsets.only(top: 1),
  //       height: 36,
  //       width: 170,
  //       child: ElevatedButton(
  //         child: Text("Отправить",
  //             style: TextStyle(color: Colors.white, fontSize: 20)),
  //         onPressed: () => funcPress(),
  //         style: ElevatedButton.styleFrom(
  //           // primary: purpleColor,
  //           // onPrimary: Colors.white,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(32.0),
  //           ),
  //         ),
  //       ));
  // }

  Future sendEmail({
    required String subject,
    required String message,
  }) async {
    final serviceId = 'service_gncc96m';
    final templateId = 'template_k23j3e9';
    final userId = 'DfFoFybo_xO5kSEYV';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_subject': subject,
          'user_message': message,
        }
      }),
    );
    print(response.body);
  }

  Widget _form() {
    return Stack(
      children: [
        ListView(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomInput(
                            controller: subjectController,
                            label: "Тема обращения",
                            icon: Icon(Icons.text_snippet)))),
                Padding(
                    padding: EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: CustomInput(
                        controller: messageController,
                        label: "Сообщение",
                        isLines: true,
                        icon: Icon(Icons.mail))),
                const SizedBox(height: 15),
              ],
            )
          ],
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Center(
              child: CustomButton(
                  onPressed: () => funcPress(), title: "Отправить"),
            ),)
      ],
    );
  }

  Widget _logo() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        child: Align(
          child: Image.asset('assets/mainLogo.png'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.transparent,
        appBar: AppBar(
             elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
          title: Text("Обращение в УК"),
        ),
        body: _form());
  }
}
