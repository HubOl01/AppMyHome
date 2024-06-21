import 'package:flutter_email_sender/flutter_email_sender.dart';

Future sendToSupport() async {
  final Email email = Email(
    body: "",
    subject: "MyHome (Tech Support)",
    recipients: ["ru-developer@mail.ru"],
    isHTML: true,
  );

  String platformResponse;

  try {
    await FlutterEmailSender.send(email);
    platformResponse = 'success';
  } catch (error) {
    print(error);
    platformResponse = error.toString();
  }
  print(platformResponse);
}