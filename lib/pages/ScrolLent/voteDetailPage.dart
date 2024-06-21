import 'package:MyAppHome/core/cubit/crud_vote_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/Data/VotingData.dart';
import '../../core/Model/votingModel.dart';
import '../../core/Styles/Colors.dart';
import '../../main.dart';

class VoteDetailPage extends StatefulWidget {
  final int id;
  const VoteDetailPage(
      {super.key,
      required this.id,});

  @override
  State<VoteDetailPage> createState() => _VoteDetailPageState();
}

class _VoteDetailPageState extends State<VoteDetailPage> {

  @override
  void initState() {
    super.initState();
    crudVoteCubit = context.read<CrudVoteCubit>();
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        title: Text("Голосование"),
      ),
      body: StreamBuilder<List<VoteModel>>(
        stream: crudVoteCubit.voteStream,
        initialData: crudVoteCubit.state,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final state = snapshot.data!;
          final vote = state[widget.id];

          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  vote.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(vote.description),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Голосование проводится с ${DateFormat("dd.MM.yyyy").format(vote.startDate)} по ${DateFormat("dd.MM.yyyy").format(vote.endDate)}",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: vote.votingQuestions.map((question) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question.questionText,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        ListCheck(
                          vote: question,
                          indexVote: widget.id,
                          list: question.options,
                          check: question.selectedOption!,
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("Контактная информация для вопросов:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(vote.contacts),
              ),
              const SizedBox(height: 30),
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
                        shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Проголосовать")),
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}

class CustomCheck extends StatefulWidget {
  final VotingQuestion vote;
  final String e;
  final int index;
  final int indexVote;
  final int check;

  const CustomCheck(
      {super.key,
      required this.e,
      required this.check,
      required this.vote,
      required this.indexVote,
      required this.index});

  @override
  State<CustomCheck> createState() => _CustomCheckState();
}

class _CustomCheckState extends State<CustomCheck> {
  bool isTrue = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile.adaptive(
        hoverColor: Colors.white,
        activeColor:
            purpleColor,
        value: widget.index == widget.check ? true : false,
        contentPadding: const EdgeInsets.all(0),
        // groupValue: e,
        title: Text(
          widget.e,
          style: TextStyle(fontSize: 16),
        ),
        onChanged: (value) {
          setState(() {
            isTrue = value!;
            widget.vote.selectedOption = widget.index;
            context.read<CrudVoteCubit>()
                .updateCheck(widget.indexVote, voting[widget.indexVote]);
            context.read<CrudVoteCubit>().readVote();
          });
        });
  }
}

class ListCheck extends StatelessWidget {
  final VotingQuestion vote;
  final List<String> list;
  final int check;
  final int indexVote;
  const ListCheck(
      {super.key,
      required this.list,
      required this.check,
      required this.indexVote,
      required this.vote});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: list
            .asMap()
            .map((i, e) => MapEntry(
                i,
                CustomCheck(
                  e: e,
                  index: i,
                  indexVote: indexVote,
                  check: check,
                  vote: vote,
                )))
            .values
            .toList());
  }
}
