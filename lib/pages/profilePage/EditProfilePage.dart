import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../chatsPages/Chats/Data/Admin.dart';
import '../chatsPages/Chats/api/firebase.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import '../../core/Utils/UserPerefer.dart';
import '../../components/ButtonWidget.dart';
import 'addImage.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool _isLoading = true;

  File? _profilePicFile;
  File? _SAVEprofilePicFile;

  @override
  void initState() {
    super.initState();
  }

  void _directUpdateImage(File? file) async {
    if (file == null) return;
    setState(() {
      _profilePicFile = file;
      //addImage(_profilePicFile!);
      _SAVEprofilePicFile = _profilePicFile;
      Image.network(myUrlAvatar);
      //addImage(_SAVEprofilePicFile!);
    });
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController surNameController = TextEditingController();

  String email = '';
  String password = '';
  String name = '';
  String middleName = '';
  String surName = '';

  Future<void> _LoginButtonActio() async {
    email = emailController.text;
    password = passwordController.text;
    name = nameController.text;
    surName = surNameController.text;
    middleName = middleNameController.text;

    // print("login: login = ${email} password = ${password}");
    // emailController.clear();
    // passwordController.clear();
    // nameController.clear();
    // surNameController.clear();
    // middleNameController.clear();
  }

  Widget _FrontButton() {
    if (!_isLoading) {
      return CircularProgressIndicator();
    } else {
      return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 50),
                InkWell(
                  onTap: () {
                    getImage();
                    print("TAPPED");
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/1946/1946429.png"),
                    radius: 80,
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Email'),
                  onChanged: (name) {},
                ),
                SizedBox(height: 30),
                TextField(
                  controller: surNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Surname'),
                  onChanged: (name) {},
                ),
                SizedBox(height: 30),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'name'),
                  onChanged: (name) {},
                ),
                SizedBox(height: 30),
                TextField(
                  controller: middleNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'middleName'),
                  onChanged: (name) {},
                ),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 40, width: 320, child: buildEditProfileButton()),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  // PICK IMAGE
  File? imageFile;
  String? xFileName;
  String? fileName;
  Future getImage() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        setState(() {
          imageFile = File(xFile.path);
          xFileName = xFile.name;
          fileName = xFileName!.split("image_picker").last;
          showDialog(
              context: context,
              builder: (context) => Container(
                    child: AlertDialog(
                      contentPadding: EdgeInsets.all(5),
                      titlePadding: EdgeInsets.all(5),
                      actionsPadding: EdgeInsets.all(5),
                      title: Text("Подтвердить?"),
                      content: CircleAvatar(
                          radius: 100,
                          backgroundImage: FileImage(
                            File(xFile.path),
                            // fit: BoxFit.cover,
                          )),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Нет")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Да"))
                      ],
                    ),
                  ));
        });
      }
    });
  }

  String image = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        title: Text("Настройки профиля"),
      ),
      body: _FrontButton(),
    );
  }

  bool exit = false;
  Widget buildEditProfileButton() => ButtonWidget(
        text: 'Save',
        onClicked: () {
          Get.back();
          // baseAPI.readAvatar();
          // _LoginButtonActio();

          //   if (email == "" || middleName == "" || name == "" || surName == "") {
          //     Fluttertoast.showToast(
          //         msg: "Ошибка! Необходимо заполнить все поля",
          //         toastLength: Toast.LENGTH_SHORT,
          //         gravity: ToastGravity.CENTER,
          //         timeInSecForIosWeb: 1,
          //         backgroundColor: Colors.red,
          //         textColor: Colors.white,
          //         fontSize: 16.0);
          //   } else {
          //     emailController.clear();
          //     passwordController.clear();
          //     nameController.clear();
          //     surNameController.clear();
          //     middleNameController.clear();
          //     Timer(Duration(milliseconds: 50), (){
          //     PushToJson(email, password, name, surName, middleName, "no");
          //     //Обновление данных для чата
          // });
          //     exit = true;
          //   }
          //     if(exit){
          //     baseAPI.updateUser(userEmail: email, userSurname: surName, userName: name, userMiddle_name: middleName, numberPhone: '');
          //     // Navigator.of(context).push(MaterialPageRoute(builder: (context) => (HomePage())));
          //     addImage(_SAVEprofilePicFile!);
          //     }
        },
      );

  funcPress() {
    void getUserTesta() async {
      final directory = await pathProvider.getApplicationSupportDirectory();
      final fileDirectory = directory.path + '/datasTest.json';
      final file = File(fileDirectory);
      final json = jsonDecode(await file.readAsString());

      print(json);
      UsersedTest nikita = UsersedTest.fromJson(json['user']);

      Timer(Duration(milliseconds: 50), () {
        nikita.numberPhone;
        nikita.surname;
        nikita.middle_name;
        nikita.name;
        print("User Data $name , and  $surName");
      });
    }

    getUserTesta();
  }
}
