import 'package:MyAppHome/core/Styles/Colors.dart';
import 'package:MyAppHome/pages/ScrolLent/archivePage.dart';
import 'package:MyAppHome/pages/ScrolLent/cardFeed.dart';
import 'package:MyAppHome/pages/ScrolLent/editor_news.dart';
import 'package:MyAppHome/pages/ScrolLent/voteDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/Model/User.dart';

import '../../core/Data/NewsData.dart';
import '../../core/Model/NewsModel.dart';
import '../../core/Utils/toastShow.dart';
import '../../core/cubit/crud_news_cubit.dart';
import '../../core/cubit/crud_vote_cubit.dart';
import '../../main.dart';
import 'JsonTest/Models_news.dart';

List<String> listNameVote = [];

class Filing extends StatefulWidget {
  final User user;
  const Filing({super.key, required this.user});

  @override
  State<Filing> createState() => _FilingState();
}

class _FilingState extends State<Filing> {
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

  @override
  void initState() {
    super.initState();
    // fetch();
    setState(() {
      news.sort((a, b) => b.date.compareTo(a.date));
    });
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {}
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor.withOpacity(.015),
      body: BlocBuilder<CrudNewsCubit, List<NewsModel>>(
        builder: (context, state) {
          return FutureBuilder(
              future: crudVoteCubit.readVote(),
              builder: (context, snapshot) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: controller,
                  itemCount: 5 + 2,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("Голосование",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 110,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: context.read<CrudVoteCubit>().state.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 300,
                                      child: GestureDetector(
                                        onTap: () => Get.to(VoteDetailPage(
                                            id: index,
                                           )),
                                        child: Material(
                                          color: Colors.white,
                                          elevation: 2,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .stretch,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const SizedBox(
                                                      width: 200,
                                                      child: Text(
                                                          "Голосование по вопросам благоустройства и инфраструктуры"),
                                                    ),
                                                    SvgPicture.asset(
                                                      "assets/icons/vote.svg",
                                                      height: 40,
                                                      width: 40,
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Голосование до ${DateFormat("dd.MM.yyyy").format(context.read<CrudVoteCubit>().state[index].endDate)}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black
                                                          .withOpacity(.5),
                                                      fontStyle:
                                                          FontStyle.italic),
                                                  textAlign:
                                                      TextAlign.right,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("Информация",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      );
                    } else if (index == 6) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(const ArchivePage());
                        },
                        child: Container(
                          width: context.width,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.12),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.archive_rounded),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Архив",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return GestureDetector(
                      onLongPress: (widget.user.about != "УК")
                          ? null
                          : () => showModalBottomSheet(
                              context: context,
                              builder: (context) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          Get.to(EditorNews(
                                            newsModel: state[index - 1],
                                            index: index - 1,
                                          ));
                                          Get.back();
                                        },
                                        leading: const Icon(
                                          Icons.edit,
                                          color: Colors.black45,
                                        ),
                                        title: Text("Изменить информацию"),
                                      ),
                                      ListTile(
                                        onTap: () {
                                          context
                                              .read<CrudNewsCubit>()
                                              .deleteNew(state[index - 1]);
                                          Get.back();
                                        },
                                        leading: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        title: const Text(
                                          "Удалить информацию",
                                          style:
                                              TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  )),
                      child: CardFeed(
                        list: state,
                        index: index - 1,
                      ),
                    );
                  },
                );
              });
        },
      ),
      floatingActionButton: (widget.user.about != "УК")
          ? null
          : FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 124, 97, 242),
              child: Icon(
                Icons.add_circle,
                color: Colors.white,
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              onTap: () {
                                Get.to(EditorNews());
                                Get.back();
                              },
                              leading: Icon(
                                Icons.newspaper,
                                color: Colors.black45,
                              ),
                              title: Text("Добавить информацию"),
                            ),
                            ListTile(
                              onTap: () {
                                toastShow(context);
                                Get.back();
                              },
                              leading: SvgPicture.asset(
                                "assets/icons/vote.svg",
                                height: 25,
                                width: 25,
                                colorFilter: ColorFilter.mode(
                                    Colors.black45, BlendMode.srcIn),
                              ),
                              title: Text("Добавить опрос"),
                            ),
                          ],
                        ));
              }),
    );
  }
}
