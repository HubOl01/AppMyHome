import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/Model/votingModel.dart';
import '../../core/Styles/Colors.dart';

class VoteDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final List<VotingQuestion> votingQuestions;
  final String contacts;
  final DateTime now;
  final DateTime startDate;
  final DateTime endDate;
  const VoteDetailPage(
      {super.key,
      required this.title,
      required this.description,
      required this.votingQuestions,
      required this.contacts,
      required this.now,
      required this.startDate,
      required this.endDate});

  @override
  State<VoteDetailPage> createState() => _VoteDetailPageState();
}

class _VoteDetailPageState extends State<VoteDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Голосование"),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(widget.description),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Голосование проводится с ${DateFormat("dd.MM.yyyy").format(widget.startDate)} по ${DateFormat("dd.MM.yyyy").format(widget.endDate)}",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: widget.votingQuestions.map((vote) {
                return Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vote.questionText,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Column(
                      children: vote.options.map((e) {
                        return CustomCheck(e: e);
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text("Контактная информация для вопросов:",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(widget.contacts),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                    padding: const WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 60, vertical: 10)),
                    backgroundColor: WidgetStatePropertyAll(purpleColor),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    elevation: const WidgetStatePropertyAll(0),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Сохранить")),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class CustomCheck extends StatefulWidget {
  final String e;

  const CustomCheck({super.key, required this.e});

  @override
  State<CustomCheck> createState() => _CustomCheckState();
}

class _CustomCheckState extends State<CustomCheck> {
  bool isTrue = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile.adaptive(
        // fillColor: WidgetStateProperty.all(purpleColor),
        hoverColor: Colors.white,
        activeColor:
            purpleColor, // overlayColor: WidgetStatePropertyAll(Colors.white),
        value: isTrue,
        contentPadding: const EdgeInsets.all(0),
        // groupValue: e,
        title: Text(
          widget.e,
          style: TextStyle(fontSize: 16),
        ),
        onChanged: (value) {
          setState(() {
            isTrue = value!;
          });
        });
  }
}
