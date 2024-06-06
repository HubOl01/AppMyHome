import 'dart:async';
import 'package:MyAppHome/pages/Login/components/customButton.dart';
import 'package:MyAppHome/pages/Login/components/customInput.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../components/TestLogin.dart';
import '../../core/Styles/Colors.dart';
import 'LoginPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController returnedPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController personalCheckController = TextEditingController();

  TextEditingController AdminEmailController = TextEditingController();
  String userStatus = "";

  String email = "";
  String name = "";
  String middleName = "";
  String surname = "";
  String password = "";
  String code = "";
  String returnedPassword = "";
  String phoneNumber = "";
  String personalCheck = "";

  String adminEmail = "";

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

  double top = 20;
  Widget _form() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: purpleColor),
                "РЕГИСТРАЦИЯ",
              ),
            ),
          ),
          SizedBox(
            height: top,
          ),
          CustomInput(
            controller: phoneNumberController,
            label: "Номер телефона",
            icon: Icon(Icons.phone),
            isNumber: true,
          ),
          SizedBox(
            height: top,
          ),
          CustomInput(
              controller: emailController,
              label: "Email",
              icon: Icon(Icons.email_outlined)),
          SizedBox(
            height: top,
          ),
          CustomInput(
              controller: surnameController,
              label: "Фамилия",
              icon: Icon(Icons.account_box_rounded)),
          SizedBox(
            height: top,
          ),
          CustomInput(
              controller: nameController,
              label: "Имя",
              icon: Icon(Icons.account_box_rounded)),
          SizedBox(
            height: top,
          ),
          CustomInput(
              controller: middleNameController,
              label: "Отчество",
              icon: Icon(Icons.account_box_rounded)),
          SizedBox(
            height: top,
          ),
          CustomInput(
            controller: personalCheckController,
            label: "Номер личного счета",
            icon: Icon(Icons.numbers),
            isNumber: true,
          ),
          SizedBox(
            height: top,
          ),
          CustomInput(
              controller: passwordController,
              isPassword: true,
              label: "Пароль",
              icon: Icon(Icons.lock_outline)),
          SizedBox(
            height: top,
          ),
          CustomInput(
              controller: returnedPasswordController,
              isPassword: true,
              label: "Повторите пароль",
              icon: Icon(Icons.lock_outline)),
          SizedBox(
            height: top,
          ),
          CustomInput(
            controller: codeController,
            label: "CODE",
            icon: Icon(Icons.email),
            isNumber: true,
          ),
          SizedBox(
            height: top,
          ),
        ],
      ),
    );
  }

///////////////////

  String encoding(String value) {
    var byte = utf8.encode(value);
    var digest = sha256.convert(byte);
    return digest.toString();
  }

  void funcPress() async {
    email = emailController.text;
    password = passwordController.text;
    code = codeController.text;
    name = nameController.text;
    surname = surnameController.text;
    middleName = middleNameController.text;
    returnedPassword = returnedPasswordController.text;
    phoneNumber = phoneNumberController.text;
    personalCheck = personalCheckController.text;

    emailController.clear();
    passwordController.clear();
    codeController.clear();
    nameController.clear();
    surnameController.clear();
    middleNameController.clear();
    returnedPasswordController.clear();
    phoneNumberController.clear();
    personalCheckController.clear();

    print(
        "data = $phoneNumber $email $surname $name $middleName $personalCheck $password $returnedPassword $code");
    if (email == "" ||
        password == "" ||
        code == "" ||
        name == "" ||
        surname == "" ||
        middleName == "" ||
        returnedPassword == "" ||
        phoneNumber == "" ||
        personalCheck == "") {
      Fluttertoast.showToast(
          msg: "Ошибка! Необходимо заполнить все поля",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (password != returnedPassword) {
      Fluttertoast.showToast(
          msg: "Ошибка! Пароли не совпадают",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      return;
    }

    String codeStatus = "error";

    print("status = $codeStatus");
    userStatus = codeStatus;

    if (codeStatus == "admin") {
      String codeCount = "";
      String baseCode = "";

      if (codeCount == "0" || codeCount == "") {
        print("$code c: $codeCount"); //count code=="0"
        Fluttertoast.showToast(
            msg:
                "Ошибка! Превышено количество регистраций по данному коду, обратитесь к руководителю ТСЖ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        // await conn.close();
        print("con close");
        return;
      } else {
        int newCount = int.parse(codeCount) - 1;
        print("register...");
        //   pushEmailForDB();

        showDialog(context: context, builder: (context) => ShowDialogg());
        // await conn.close();
        print("con close");
        runApp(LoginPage());
      }
    }
    //
    //
    else if (codeStatus == "user") {
    } else {
      Fluttertoast.showToast(
          msg: "Ошибка! Введен неверный код",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: false,
            colorScheme: ColorScheme.fromSeed(seedColor: purpleColor)),
        home: Builder(builder: (context) {
          pushEmailForDB(String email, String adminCode, String code) async {
            print("email = $email adminCode = $adminCode code = $code");

            int dataStatus = 0;

            print("dataStatus =  $dataStatus");
            if (dataStatus == 1) {
              // var pushEmail = await conn.execute("insert into code_table(admin_code, code, main_mail) values ('$adminCode','$code','$email');");
            }

            return LoginPage();
          }

          return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    _logo(),
                    _form(),
                    CustomButton(
                        onPressed: () {
                          funcPress();

                          print("userStatus = $userStatus");

                          Timer(Duration(seconds: 1), () {
                            if (userStatus == "admin") {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text('This is a text'),
                                    content: Text('this is the content'),
                                    actions: [
                                      TextField(
                                        controller: AdminEmailController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          labelText: 'Email',
                                        ),
                                      ),
                                      Center(
                                        child: Row(
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                              },
                                              child: Text('Back'),
                                            ),
                                            SizedBox(height: 30),
                                            TextButton(
                                              onPressed: () {
                                                adminEmail =
                                                    AdminEmailController.text;

                                                print(
                                                    "adminEmail = $adminEmail ");

                                                runApp(LoginPage());
                                                Navigator.of(context).pop(true);

                                                pushEmailForDB(
                                                    adminEmail, "1490", "TEST");
                                                AdminEmailController.clear();
                                              },
                                              child: Text('Save'),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          });
                        },
                        title: "Зарегистрироваться"),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      onPressed: () {
                        return runApp(LoginPage());
                      },
                      title: "Вход",
                      isOutline: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ));
        }),
      ),
    );
  }
}
