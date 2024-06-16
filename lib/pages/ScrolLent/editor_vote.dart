import 'package:MyAppHome/components/customInput.dart';
import 'package:flutter/material.dart';

class EditorVote extends StatefulWidget {
  const EditorVote({super.key});

  @override
  State<EditorVote> createState() => _EditorVoteState();
}

class _EditorVoteState extends State<EditorVote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Добавление опроса"),),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          CustomInput(controller: titleController, label: "Заголовок", isLines: true,),
          const SizedBox(
            height: 10,
          ),
          CustomInput(controller: descController, label: "Описание", isLines: true,),
          const SizedBox(
            height: 10,
          ),
          CustomInput(controller: titleController, label: "Заголовок"),
          const SizedBox(
            height: 10,
          ),
          CustomInput(controller: titleController, label: "Описание"),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
