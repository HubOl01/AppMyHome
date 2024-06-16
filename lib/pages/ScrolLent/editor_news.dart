import 'package:MyAppHome/components/customInput.dart';
import 'package:flutter/material.dart';

class EditorNews extends StatefulWidget {
  const EditorNews({super.key});

  @override
  State<EditorNews> createState() => _EditorNewsState();
}

class _EditorNewsState extends State<EditorNews> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Добавление информации"),),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 10,
          ),
          CustomInput(controller: titleController, label: "Заголовок", isLines: true,),
          const SizedBox(
            height: 10,
          ),
          CustomInput(controller: descController, label: "Описание", isLines: true,),
          const SizedBox(
            height: 10,
          ),
          
        ],
      ),
    );
  }
}
