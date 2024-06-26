import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

String savedImagePath = "";

// XFile? image;

// Future getImage() async {
//   final ImagePicker _picker = ImagePicker();
//   final img = await _picker.pickImage(source: ImageSource.gallery);
//   setState(() {
//     image = img;
//   });
// }

Future<String> saveImage(File? imageFile) async {
  if (imageFile == null) return "";

  final directory = await getApplicationDocumentsDirectory();
  final fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
  final savedImage = await imageFile.copy('${directory.path}/$fileName');
  savedImagePath = savedImage.path;

  final file = File(savedImagePath);
  if (await file.exists()) {
    return savedImage.path;
  } else {
    print('Ошибка при сохранении изображения: файл не существует');
    return "";
  }
}

Future<void> deleteImage(String imagePath) async {
  try {
    final file = File(imagePath);

    if (await file.exists()) {
      await file.delete();
      print('Фото успешно удален: $imagePath');
    } else {
      print('Фото не существует');
    }
  } catch (e) {
    print('Ошибка при удалении фото: $e');
  }
}
