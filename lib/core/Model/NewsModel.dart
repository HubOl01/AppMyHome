class NewsModel {
  String headName;
  String image;
  String text;
  bool isImage;
  DateTime date;

  NewsModel({
    required this.headName,
    required this.text,
    required this.image,
    required this.date,
    required this.isImage,
  });
}
