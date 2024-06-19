import 'dart:io';

import 'package:MyAppHome/components/customButton.dart';
import 'package:MyAppHome/components/customInput.dart';
import 'package:MyAppHome/core/Model/NewsModel.dart';
import 'package:MyAppHome/core/cubit/crud_news_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../core/Data/NewsData.dart';
import '../../core/Styles/Colors.dart';
import '../../core/functions/workImage.dart';

class EditorNews extends StatefulWidget {
  const EditorNews({super.key});

  @override
  State<EditorNews> createState() => _EditorNewsState();
}

class _EditorNewsState extends State<EditorNews> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  XFile? image;

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final img = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Добавление информации"),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomInput(
            controller: titleController,
            label: "Заголовок",
            isLines: true,
            onChanged: (p0) => setState(() {
              titleController.text = p0;
            }),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomInput(
            controller: descController,
            label: "Описание",
            isLines: true,
            onChanged: (p0) => setState(() {
              descController.text = p0;
            }),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 50,
                width: 100,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(width: 2, color: purpleColor))),
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.transparent),
                        elevation: WidgetStatePropertyAll(0)),
                    onPressed: () {
                      getImage();
                    },
                    child: Center(
                        child: Icon(
                      Icons.add_photo_alternate_outlined,
                      color: purpleColor,
                    ))),
              ),
            ),
          ),

          if (image != null)
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Пример картинки на новостной ленте",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Stack(
                    children: [
                      Image.file(
                        File(
                          image!.path,
                        ),
                        height: context.height * 0.33,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () => setState(() {
                              image = null;
                            }),
                            icon: Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                            splashRadius: 15,
                            splashColor: Colors.red,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          // Padding(
          //   // padding: const EdgeInsets.symmetric(vertical: 10.0),
          //   child:
          // ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: CustomButton(
                onPressed: titleController.value.text.isEmpty ||
                        descController.value.text.isEmpty
                    ? null
                    : () {
                        if (titleController.text.trim().isNotEmpty &&
                            descController.text.trim().isNotEmpty) {
                          setState(() {
                            context.read<CrudNewsCubit>().addNews(NewsModel(
                                headName: titleController.text,
                                text: descController.text,
                                image: image != null ? image!.path : "",
                                date: DateTime.now(),
                                isImage: image != null ? true : false));
                            context.read<CrudNewsCubit>().allNews();
                            // news.add(NewsModel(
                            //     headName: titleController.text,
                            //     text: descController.text,
                            //     image: image != null ? image!.path : "",
                            //     date: DateTime.now(),
                            //     isImage: image != null ? true : false));
                          });
                          print("news: ${news.length}");
                          Get.back();
                          Get.back();
                        }
                      },
                title: "Добавить"),
          ),
        ],
      ),
    );
  }
}
