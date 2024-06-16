import 'package:MyAppHome/core/Styles/Colors.dart';
import 'package:MyAppHome/pages/ScrolLent/archivePage.dart';
import 'package:MyAppHome/pages/ScrolLent/editor_news.dart';
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
import 'JsonTest/Models_news.dart';
import 'SurveyPage.dart';
import 'editor_vote.dart';

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
    Size size = MediaQuery.of(context).size;

    if (status == 'admin') {
      return Scaffold(
        backgroundColor: purpleColor.withOpacity(.015),
        body: ListView.builder(
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
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: voting.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 300,
                              child: GestureDetector(
                                onTap: () => Get.to(VoteDetailPage(
                                    title: voting[index].title,
                                    description: voting[index].description,
                                    votingQuestions:
                                        voting[index].votingQuestions,
                                    contacts: voting[index].contacts,
                                    now: voting[index].now,
                                    startDate: voting[index].startDate,
                                    endDate: voting[index].endDate)),
                                child: Material(
                                  color: Colors.white,
                                  elevation: 2,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      //  mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          // mainAxisSize: MainAxisSize.min,
                                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                          "Голосование до ${DateFormat("dd.MM.yyyy").format(voting[index].endDate)}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  Colors.black.withOpacity(.5),
                                              fontStyle: FontStyle.italic),
                                          textAlign: TextAlign.right,
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Информация",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.archive_rounded),
                      const SizedBox(
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
            return CardFeed(
              list: news,
              index: index - 1,
            );
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
                                onTap: () => Get.to(EditorNews()),
                                leading: Icon(
                                  Icons.newspaper,
                                  color: Colors.black45,
                                ),
                                title: Text("Добавить информацию"),
                              ),
                              ListTile(
                                onTap: () => Get.to(EditorVote()),
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
    } else {
      return Center(
        child: Scaffold(
          backgroundColor: Color.fromARGB(250, 219, 219, 219),
          body: ListView.builder(
            itemCount: NewsForUsers.length,
            itemBuilder: (context, int index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      //news[index].HeadName,
                      NewsForUsers[index].title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      //news[index].Text,
                      NewsForUsers[index].text,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  if (news[index].isImage == true)
                    Container(
                      height: size.height * 0.33,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4)),
                        child: Image.network(NewsForUsers[index].image,
                            fit: BoxFit.cover,
                            height: size.height * 0.33,
                            errorBuilder: (context, url, error) => Center(
                                    child: new Text(
                                  "Картинка недоступна.\n Возможно нет интернета или картинка не действительна",
                                  textAlign: TextAlign.center,
                                )),
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                  child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ));
                            }),
                      ),
                    ),
                ]),
              );
            },
          ),
        ),
      );
    }
  }
}

class CardFeed extends StatefulWidget {
  final int index;
  final List<NewsModel> list;
  const CardFeed({
    super.key,
    required this.index,
    required this.list,
  });

  @override
  State<CardFeed> createState() => _CardFeedState();
}

class _CardFeedState extends State<CardFeed> {
  bool isDeploy = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          print("isDeploy: ${isDeploy}");
          isDeploy = !isDeploy;
        });
      },
      child: Card(
        // color: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              // news[index].HeadName,
              widget.list[widget.index].headName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (widget.list[widget.index].isImage)
            CachedNetworkImage(
              imageUrl: widget.list[widget.index].image,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const SizedBox(
                height: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        "Картинка недоступна.\n Возможно нет интернета или картинка не действительна",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              progressIndicatorBuilder: (context, url, progress) => SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(
                    color: purpleColor,
                  ),
                ),
              ),
            ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              //widget.list[index-1].Text,
              widget.list[widget.index].text,
              maxLines:
                  widget.list[widget.index].isImage && !isDeploy ? 3 : null,
              overflow: widget.list[widget.index].isImage && !isDeploy
                  ? TextOverflow.ellipsis
                  : null,
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Опубликовано ${DateFormat("dd.MM.yyyy").format(widget.list[widget.index].date)}",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(.5),
                  fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ]),
      ),
    );
  }
}
