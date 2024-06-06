import 'package:MyAppHome/core/Styles/Colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/Model/User.dart';

import '../../core/Data/NewsData.dart';
import '../../core/Model/NewsModel.dart';
import 'JsonTest/Models_news.dart';
import 'SurveyPage.dart';

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
    news = news.reversed.toList();
    Size size = MediaQuery.of(context).size;

    if (status == 'admin') {
      return Center(
        child: Scaffold(
          backgroundColor: purpleColor.withOpacity(.015),
          body: ListView.builder(
            controller: controller,
            itemCount: news.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Голосование",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ],
                );
              }
              return Card(
                // color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          // news[index].HeadName,
                          news[index - 1].headName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (news[index - 1].isImage)
                        CachedNetworkImage(
                          imageUrl: news[index - 1].image,
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Text(
                                    "Картинка недоступна.\n Возможно нет интернета или картинка не действительна",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          progressIndicatorBuilder: (context, url, progress) =>
                              SizedBox(
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
                          //news[index-1].Text,
                          news[index - 1].text,
                          maxLines: news[index - 1].isImage ? 3 : null,
                          overflow: news[index - 1].isImage
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
                          "Опубликовано ${DateFormat("dd.MM.yyyy").format(news[index - 1].date)}",
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.only(top: 10.0),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0))),
                          title: Text("Добавление"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              32.0))),
                                              title: Text('Добавить новость'),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    TextField(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: hint,
                                                      ),
                                                      controller:
                                                          newsController,
                                                    ),
                                                    TextField(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: hint1,
                                                      ),
                                                      controller:
                                                          textController,
                                                    ),
                                                    TextField(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: img,
                                                      ),
                                                      controller: ControlImage,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  // style: ElevatedButton
                                                  //     .styleFrom(
                                                  //   backgroundColor:
                                                  //       purpleColor,
                                                  //   foregroundColor:
                                                  //       Colors.white,
                                                  //   elevation: 3,
                                                  //   shape:
                                                  //       RoundedRectangleBorder(
                                                  //           borderRadius:
                                                  //               BorderRadius
                                                  //                   .circular(
                                                  //                       20.0)),
                                                  //   minimumSize:
                                                  //       Size(100, 50),
                                                  // ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    "Назад",
                                                  ),
                                                ),
                                                // Padding(
                                                //   padding: EdgeInsets.only(
                                                //       right: 10),
                                                // ),
                                                TextButton(
                                                    // style: ElevatedButton
                                                    //     .styleFrom(
                                                    //   backgroundColor:
                                                    //       Color.fromARGB(255,
                                                    //           124, 97, 242),
                                                    //           foregroundColor: Colors.white,
                                                    //   elevation: 3,
                                                    //   shape: RoundedRectangleBorder(
                                                    //       borderRadius:
                                                    //           BorderRadius
                                                    //               .circular(
                                                    //                   20.0)),
                                                    //   minimumSize:
                                                    //       Size(100, 50),
                                                    // ),
                                                    onPressed: () async {
                                                      setState(() {
                                                        news.add(NewsModel(
                                                            date:
                                                                DateTime.now(),
                                                            headName:
                                                                newsController
                                                                    .text,
                                                            text: textController
                                                                .text,
                                                            isImage: ControlImage
                                                                            .text ==
                                                                        "" ||
                                                                    ControlImage
                                                                        .text
                                                                        .isEmpty
                                                                ? false
                                                                : true,
                                                            image: ControlImage
                                                                .text));
                                                      });

                                                      // final conn = await MySQLConnection.createConnection(
                                                      //   host: "185.231.155.185",
                                                      //   port: 3306,
                                                      //   userName: "user",
                                                      //   password: "password",
                                                      //   databaseName: "data", // optional
                                                      // );
                                                      // await conn.connect();
                                                      // print("Conected ${ControlText.text}");

                                                      // var res = await conn.execute(
                                                      //   "INSERT INTO News (title_news, osn_news, image) VALUES (:title_news, :osn_news, :image)",
                                                      //   {
                                                      //     "title_news": ControlNews.text,
                                                      //     "osn_news": ControlText.text,
                                                      //     "image": ControlImage.text,
                                                      //   },
                                                      // );

                                                      newsController.clear();
                                                      textController.clear();
                                                      ControlImage.clear();

                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('Добавить')),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                ),
                                              ]);
                                        });
                                  },
                                  child: const Text("Добавить новость")),
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0))),
                                        title: Text("Добавить опрос"),
                                        content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Qustions",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              TextField(
                                                decoration: InputDecoration(
                                                  hintText: hn,
                                                ),
                                                controller: headNameController,
                                              ),
                                              Text("Response options",
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              TextField(
                                                decoration: InputDecoration(
                                                  hintText: ro,
                                                ),
                                                controller: nameVoteController,
                                              ),
                                              TextButton(
                                                  // style:
                                                  //     ElevatedButton.styleFrom(
                                                  //   backgroundColor:
                                                  //       Color.fromARGB(
                                                  //           255, 124, 97, 242),
                                                  //   foregroundColor:
                                                  //       Colors.white,
                                                  //   elevation: 3,
                                                  //   shape:
                                                  //       RoundedRectangleBorder(
                                                  //           borderRadius:
                                                  //               BorderRadius
                                                  //                   .circular(
                                                  //                       20.0)),
                                                  //   minimumSize: Size(100, 50),
                                                  // ),
                                                  onPressed: () {
                                                    setState(() {
                                                      listNameVote.clear();
                                                    });
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                SurveyPage()));
                                                  },
                                                  child: Text(
                                                      "Добавить ответ...")),
                                            ]),
                                        actions: [
                                          TextButton(
                                            // style: ElevatedButton.styleFrom(
                                            //   backgroundColor:
                                            //       Color.fromARGB(
                                            //           255, 124, 97, 242),
                                            //           foregroundColor: Colors.white,
                                            //   elevation: 3,
                                            //   shape: RoundedRectangleBorder(
                                            //       borderRadius:
                                            //           BorderRadius.circular(
                                            //               20.0)),
                                            // minimumSize: Size(100, 50),
                                            // ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Назад"),
                                          ),
                                          TextButton(
                                              // style:
                                              //     ElevatedButton.styleFrom(
                                              //   backgroundColor:
                                              //       Color.fromARGB(
                                              //           255, 124, 97, 242),
                                              //           foregroundColor: Colors.white,
                                              //   elevation: 3,
                                              //   shape:
                                              //       RoundedRectangleBorder(
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(
                                              //                       20.0)),
                                              //   minimumSize: Size(100, 50),
                                              // ),
                                              onPressed: () async {
                                                setState(() {
                                                  news.add(NewsModel(
                                                    headName:
                                                        headNameController.text,
                                                    text:
                                                        nameVoteController.text,
                                                    image: "",
                                                    isImage: false,
                                                    date: DateTime.now(),
                                                  ));
                                                });

                                                // final conn = await MySQLConnection.createConnection(
                                                //   host: "185.231.155.185",
                                                //   port: 3306,
                                                //   userName: "user",
                                                //   password: "password",
                                                //   databaseName: "data", // optional
                                                // );
                                                // await conn.connect();
                                                // print("Conected");

                                                // var res = await conn.execute(
                                                //   "INSERT INTO News (name_vote, surv_name) VALUES (:name_vote, :surv_name)",
                                                //   {
                                                //     "name_vote": ControlHeadName.text,
                                                //     "surv_name": ControlnameVote.text,
                                                //   },
                                                // );

                                                headNameController.clear();
                                                nameVoteController.clear();

                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Добавить опрос')),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text("Добавить опрос"),
                              ),
                              // Padding(padding: EdgeInsets.only(top: 30)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 124, 97, 242),
                                      foregroundColor: Colors.white,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      // minimumSize: Size(100, 50),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Назад")),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }),
        ),
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
