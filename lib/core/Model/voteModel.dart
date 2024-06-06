class VoteModel {
  String headName;
  String text;
  String image;
  bool isImage;
  DateTime date;

  VoteModel({
    required this.headName,
    required this.text,
    required this.image,
    required this.date,
    this.isImage = false,
  });
}
