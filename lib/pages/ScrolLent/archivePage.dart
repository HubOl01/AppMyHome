import 'package:MyAppHome/core/Styles/Colors.dart';
import 'package:MyAppHome/pages/ScrolLent/voteDetailPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/Data/VotingData.dart';
import '../../core/Model/User.dart';

import '../../core/Data/NewsData.dart';
import '../../core/Model/NewsModel.dart';
import 'Filling.dart';
import 'JsonTest/Models_news.dart';
import 'SurveyPage.dart';

List<String> listNameVote = [];

class ArchivePage extends StatefulWidget {
  const ArchivePage({super.key});

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  int last = 5;
  final controller = ScrollController();

  List<NewsForUser> NewsForUsers = [];

  String hint1 = 'Text';
  String hint = 'Title';
  String hn = 'SurvName';
  String ro = 'responopt';
  String img = 'image';
  String status = 'admin';

  late String userToDO;

  // List<NewsModels> newsT = [];
  TextEditingController newsController = TextEditingController();
  TextEditingController textController = TextEditingController();
  TextEditingController countController = TextEditingController();
  TextEditingController nameVoteController = TextEditingController();
  TextEditingController headNameController = TextEditingController();
  TextEditingController ControlImage = TextEditingController();
  List<NewsModel> archives = [];
  @override
  void initState() {
    super.initState();
    // fetch();
    setState(() {
      news.sort((a, b) => b.date.compareTo(a.date));
      for (int i = 5; i < news.length; i++) {
        archives.add(news[i]);
      }
    });
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {}
    });
  }

  @override
  void dispose() {
    controller.dispose();
    archives.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: purpleColor.withOpacity(.015),
      appBar: AppBar(
        title: Text("Архив"),
      ),
      body: Container(
        color: purpleColor.withOpacity(.015),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          controller: controller,
          itemCount: archives.length,
          itemBuilder: (context, index) {
            return CardFeed(
              list: archives,
              index: index,
            );
          },
        ),
      ),
    );
  }
}
