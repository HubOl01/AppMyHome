import 'dart:convert';
import 'package:command_flutter/Login/LOginPage.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysql_client/mysql_client.dart';

import '../Widget/ButtonLoginPage.dart';


class RegisterPage extends StatelessWidget {

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController returnedPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController personalCheckController = TextEditingController();

  String email = "";
  String name = "";
  String middleName = "";
  String surname = "";
  String password = "";
  String code = "";
  String returnedPassword = "";
  String phoneNumber = "";
  String personalCheck = "";

  @override
////////////////////
  Widget _logo() {
    return Padding(
      padding: EdgeInsets.only( bottom: 10),
      child: Container(
        child: Align(
          child: Image.asset('assets/mainLogo.png'),
        ),
      ),
    );
  }
  ////////////////
  Widget _inputNumbers(Icon icon, String hint, TextEditingController controller,
      bool hidden) {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      child: TextField(
        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        controller: controller,
        obscureText: hidden,
        style: TextStyle(fontSize: 20, color: Color.fromARGB(200, 120, 95, 221)),
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(200, 227, 228, 251),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0)),
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey),
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(200, 227, 228, 251), width: 3),
            borderRadius: BorderRadius.circular(30.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(200, 227, 228, 251), width: 1),
            borderRadius: BorderRadius.circular(30.0),
          ),
          prefixIcon: Padding(padding: EdgeInsets.only(left: 20, right: 10),
            child: IconTheme(
              data: IconThemeData(
                  color: Colors.purple
              ),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
//////////////////

  Widget _input(Icon icon, String hint, TextEditingController controller,
      bool hidden) {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      child: TextField(

        controller: controller,
        obscureText: hidden,
        style: TextStyle(fontSize: 20, color: Color.fromARGB(200, 120, 95, 221)),
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(200, 227, 228, 251),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0)),
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey),
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(200, 227, 228, 251), width: 3),
            borderRadius: BorderRadius.circular(30.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(200, 227, 228, 251), width: 1),
            borderRadius: BorderRadius.circular(30.0),
          ),
          prefixIcon: Padding(padding: EdgeInsets.only(left: 20, right: 10),
            child: IconTheme(
              data: IconThemeData(
                  color: Colors.purple
              ),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
//////////////////

  Widget _form() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18, bottom: 10),
            child:  Align(
              alignment: Alignment.bottomLeft,
              child: Text( textAlign: TextAlign.left,  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold), "РЕГИСТРАЦИЯ"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _inputNumbers(
                Icon(Icons.phone), "+7-912-345-67-89", phoneNumberController, false),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20,),
            child: _input(
                Icon(Icons.email), "example@mail.ru", emailController, false),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _input(Icon(Icons.account_box_rounded), "Фамилия", surnameController, false),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20,),
            child: _input(
                Icon(Icons.account_box_rounded), "Имя", nameController, false),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _input(Icon(Icons.account_box_rounded), "Отчество", middleNameController, false),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _inputNumbers(Icon(Icons.numbers), "Номер личного счета", personalCheckController, false),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20,),
            child: _input(Icon(Icons.lock), "Пароль", passwordController, true),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _input(
                Icon(Icons.lock), "Повторите пароль", returnedPasswordController, true),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _inputNumbers(
                Icon(Icons.email), "CODE", codeController, false),
          ),
          SizedBox(height: 20,),
          Padding(
              child: Container(
                height: 60,
                width: 270,
                child: _regButton()
                //_button(),
              ),
              padding: EdgeInsets.only(left: 20, right: 20,)
          ),
        ],
      ),
    );
  }

///////////////////

  Widget _logPageButton(){

    return Container(
        margin: EdgeInsets.only(top: 8, bottom: 8),
        // padding: EdgeInsets.only(top: 8),
        height: 42,
        width: 110,
        child: ElevatedButton(
          child: Text("ВХОД", style: TextStyle(color: Colors.white, fontSize: 18)),
          onPressed: (){ print('tap-tap'); return runApp(LoginPage()); },
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(200, 158, 122, 244),
            onPrimary: Colors.cyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        )
    );
  }

//////////////////

  Widget _regButton(){
    return Container(
        child: ElevatedButton(
          child: Text("ЗАРЕГИСТРИРОВАТЬСЯ", style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () {
            return funcPress();
            },
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(200, 158, 122, 244),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        )

    );
  }

/////////////////

/////////
  String encoding(String value){
    var byte = utf8.encode(value);
    var digest = sha256.convert(byte);
    return digest.toString();
  }
///
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

      print("data = $phoneNumber $email $surname $name $middleName $personalCheck $password $returnedPassword $code");
      if(email == "" || password == "" || code == "" || name == "" || surname == "" || middleName == "" || returnedPassword == "" || phoneNumber == "" || personalCheck == ""){
        Fluttertoast.showToast(
            msg: "Ошибка! Необходимо заполнить все поля",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb:
            1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return;
      }


      if(password != returnedPassword){

        Fluttertoast.showToast(
            msg: "Ошибка! Пароли не совпадают",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb:
            1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

        return ;
      }


      print("Connecting to mysql server...");
      final conn = await MySQLConnection.createConnection(
        host: "185.231.155.185",
        port: 3306,
        userName: "user",
        password: "password",
        databaseName: "data", // optional
      );
      await conn.connect();
      print("Connected");

      var res = await conn.execute("select count(id) from final_user where user_email = '$email';");
      for (final row in res.rows) {
        if (row.colAt(0) != "0") {
          Fluttertoast.showToast(
              msg: "Ошибка! Пользователь с такими данными уже зарегистрирован",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb:
              1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          await conn.close();
          print("con close");
          return;
        }
      }
      pushEmailForDB(){
        ButtonLoginReg();
        print("push email");
      }

      String codeStatus = "error";

      var status = await conn.execute("select if (admin_code='$code' and base_code!='','admin',if(base_code='$code' and admin_code ='','user','error')) from reg_table;");
          for(final row in status.rows){
            if(row.colAt(0).toString()!="error"){
              codeStatus = row.colAt(0).toString();
              break;
            }
          }
          print("status = $codeStatus");

      if(codeStatus=="admin") {
        String codeCount = "";
        String baseCode = "";
        var count = await conn.execute(
            "select count, base_code from reg_table where admin_code = '$code';");//|| base_code = '$code'
        for (final row in count.rows) {
          codeCount = row.colAt(0).toString();
          baseCode = row.colAt(1).toString();
        }

        if (codeCount == "0" || codeCount == "") {
          print("$code c: $codeCount");//count code=="0"
          Fluttertoast.showToast(
              msg: "Ошибка! Превышено количество регистраций по данному коду, обратитесь к руководителю ТСЖ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb:
              1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          await conn.close();
          print("con close");
          return;
        }
        else {

          int newCount = int.parse(codeCount) - 1;
          var regUser = await conn.execute(
              "insert into final_user(user_email, password, surname, name, middle_name, status, code, personal_check, phone_number) values ('$email','${encoding(
                  password)}','$surname','$name','$middleName','admin','$baseCode','$personalCheck','$phoneNumber');");

          var countIncrement = await conn.execute("update reg_table set count = '$newCount' where base_code = '$baseCode' and admin_code = '$code'");
          print("register...");
          pushEmailForDB();
          await conn.close();
          print("con close");
          runApp(LoginPage());
        }
      }

     else if(codeStatus=="user"){
        //user code
        var res = await conn.execute("select count(id) from final_user where user_email = '$email';");
        for (final row in res.rows) {
          if (row.colAt(0) != "0") {
            Fluttertoast.showToast(
                msg: "Ошибка! Пользователь с такими данными уже зарегистрирован",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb:
                1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
            await conn.close();
            print("con close");
            return;
          }
        }
        String codeCount = "";
        var count = await conn.execute("select count from reg_table where base_code = '$code' and admin_code = '';");
        for (final row in count.rows) {
          codeCount = row.colAt(0).toString();
        }

        if(codeCount=="0" || codeCount == ""){ //count code=="0"
          Fluttertoast.showToast(
              msg: "Ошибка! Превышено количество регистраций по данному коду, обратитесь к руководителю ТСЖ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb:
              1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          await conn.close();
          print("con close");
          return;
        }
        else {
          int newCount = int.parse(codeCount) - 1;
          var regUser = await conn.execute(
              "insert into final_user(user_email, password, surname, name, middle_name, status, code, personal_check, phone_number) values ('$email','${encoding(
                  password)}','$surname','$name','$middleName','user','$code','$personalCheck','$phoneNumber');");
          var countIncrement = await conn.execute("update reg_table set count = '$newCount' where base_code = '$code' and admin_code = ''");
          print("register...");
          await conn.close();
          print("con close");
          runApp(LoginPage());
        }
      }
      else{
        Fluttertoast.showToast(
            msg: "Ошибка! Введен неверный код",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb:
            1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body:
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _logo(),
              _form(),
              _logPageButton(),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    String email = '';
    email = emailController.text;

    Future<void> _LoginButtonActio() async {
      email = emailController.text;
      print("login: login = ${email}");
      emailController.clear();
      print("login: login = ${email}");
    }

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () => Navigator.pop(context, 'Cancel'),
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.pop(context, 'Cancel');
        _LoginButtonActio(); },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Необходимо ввести @mail УК, для отправления писем"),
      content: TextField(
        controller: emailController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            labelText: 'Email'
        ),
        onChanged: (name) {},
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Container(
          child: AlertDialog(
            title: Text("My title"),
            content: Text("This is my message."),
            actions: [
                TextButton(
                child: Text("OK"),
                onPressed: () { },
              ),
            ],
          ),
        );
        return alert;
      },
    );

    // showDialog(
    //     context: context,
    //     builder: (context) => Container(
    //       child: AlertDialog(
    //         contentPadding: EdgeInsets.all(5),
    //         titlePadding: EdgeInsets.all(5),
    //         actionsPadding: EdgeInsets.all(5),
    //         title: Text("Подтвердить?"),
    //         content: Container(
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 Icon(
    //                   Icons.insert_drive_file,
    //                   size: 50,
    //                 ),
    //                 SizedBox(
    //                     height: 50,
    //                     child: Center(child: Text(pickedFile!.name))),
    //                 SizedBox(
    //                   child: Row(
    //                     children: [
    //                       Flexible(
    //                         child: TextFormField(
    //                           minLines: 1,
    //                           maxLines: 2,
    //                           controller: _controllerFile,
    //                           scrollPadding: EdgeInsets.all(1),
    //                           decoration: InputDecoration(
    //                               contentPadding: EdgeInsets.symmetric(
    //                                   vertical: 1, horizontal: 2),
    //                               border: InputBorder.none,
    //                               hintText: "Напишите сообщение..."),
    //                         ),
    //                       ),
    //                       IconButton(
    //                         onPressed: () {
    //                           _controllerFile.clear();
    //                         },
    //                         icon: Icon(
    //                           Icons.close,
    //                           size: 20,
    //                         ),
    //                         splashRadius: 20,
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             )),
    //         actions: [
    //           TextButton(
    //               onPressed: () {
    //                 checkedFile = false;
    //                 uploadFile();
    //                 Navigator.pop(context);
    //               },
    //               child: Text("Нет")),
    //           TextButton(
    //               onPressed: () {
    //                 if (_controller.text.trim() != "") sendMessage();
    //                 checkedFile = true;
    //                 uploadFile();
    //                 Navigator.pop(context);
    //               },
    //               child: Text("Да"))
    //         ],
    //       ),
    //     ));
  }
}