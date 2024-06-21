import 'dart:async';
import 'dart:convert';

import 'package:MyAppHome/core/Model/User.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../../components/customButton.dart';
import '../../components/customInput.dart';
import '../../core/Data/usersData.dart';
import '../../core/Model/addUser.dart';
import '../../core/Styles/Colors.dart';
import '../../main.dart';
import '../chatsPages/Chats/Data/Admin.dart';
import 'RegisterPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    setState(() {
      emailController.text = "12@test.ru";
      passwordController.text = "12121";
    });
    super.initState();
    
  }

  TextEditingController nameController = TextEditingController();

  TextEditingController surNameController = TextEditingController();

  TextEditingController middleNameController = TextEditingController();

  String name = "";

  String surName = "";

  String middleName = "";

  bool logged = false;

  String email = "";

  String password = "";

  Widget _logo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        child: Align(
          child: Image.asset('assets/mainLogo.png'),
        ),
      ),
    );
  }

  Widget _form() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 15,
            top: 30,
          ),
          child: Center(
            child: Text(
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: purpleColor),
                "ДОБРО ПОЖАЛОВАТЬ!"),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: CustomInput(
                controller: emailController,
                isPassword: false,
                label: "Email",
                icon: const Icon(Icons.email_outlined))),
        Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: CustomInput(
                controller: passwordController,
                isPassword: true,
                label: "Пароль",
                icon: const Icon(Icons.lock_outline))),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  String encoding(String value) {
    var byte = utf8.encode(value);
    var digest = sha256.convert(byte);
    return digest.toString();
  }

  User userT = users[0];

  void funcPress() {
    logged = false;
    print("login button");
    Future<void> _LoginButtonAction() async {
      email = emailController.text;
      password = passwordController.text;
      print("login: login = ${email} password = ${password}");

      if (email == "" || password == "") {
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
      // emailController.clear();
      // passwordController.clear();

      for (int i = 0; i < users.length; i++) {
        if (email == users[i].email && password == users[i].password) {
          logged = true;
          print(logged);
          userT = users[i];
          break;
        }
        logged = false;
      }
      print("hello, $logged");
      if (logged) {
        // runApp(MyApp());
        // await conn.close();
        print("con close");
        // getUsers();
        myId = userT.id;
        addUser(userT.id, userT.email, '', userT.name, '', '', '', '',
            userT.numberPhone);
        return runApp(MyApp(user: userT));
      } else {
        Fluttertoast.showToast(
            msg: "Ошибка! Неправильный email или пароль",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        // await conn.close();
        print("con close");

        return runApp(LoginPage());
      }
    }

    _LoginButtonAction();
    print("exit");
  }

  @override
  Widget build(BuildContext context) {
    print('LoginPage');
    return KeyboardDismissOnTap(
      child: MaterialApp(
        theme: ThemeData(
            useMaterial3: false,
            colorScheme: ColorScheme.fromSeed(seedColor: purpleColor)),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _logo(),
                _form(),
                CustomButton(
                  title: "Вход",
                  onPressed: () => funcPress(),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  onPressed: () => runApp(const RegisterPage()),
                  title: "Регистрация",
                  isOutline: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
