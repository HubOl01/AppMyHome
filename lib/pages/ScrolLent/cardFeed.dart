import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/Model/NewsModel.dart';
import '../../core/Styles/Colors.dart';

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
          if (widget.list[widget.index].isImage &&
              widget.list[widget.index].image.contains('http'))
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
          if (widget.list[widget.index].isImage &&
              !widget.list[widget.index].image.contains('http'))
            Image.file(
              File(widget.list[widget.index].image),
              fit: BoxFit.cover,
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
