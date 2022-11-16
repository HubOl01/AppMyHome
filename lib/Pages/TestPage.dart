import 'dart:io';
import 'package:editable_image/editable_image.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Directory _appDocDir;
  File? _profilePicFile;
  bool Flag = true;

  @override
  void initState() {
    final Flag;
    super.initState();
    getApplicationDocumentsDirectory().then((appDocDir) {
      _appDocDir = appDocDir;
      _profilePicFile = File(join(appDocDir.path, 'profile_picture.png'));
      setState(() {});
    });
  }
  void _saveImageToAppDirectoryForNextUses(File? file) async {
    if (file == null) return;

    if (_profilePicFile != null) {
      await _profilePicFile!.delete(recursive: true);

      setState(() {
        _profilePicFile = null;
      });
    }

    imageCache.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _profilePicFile = File(join(_appDocDir.path, 'profile_picture.png'));
      await file.copy(_profilePicFile!.path);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: EditableImage(
        // Define the method that will run on the change process of the image.
        onChange: (file) => _saveImageToAppDirectoryForNextUses(file),

        // Define the source of the image.
        image: _profilePicFile != null
            ? Image.file(_profilePicFile!, fit: BoxFit.cover)
            : null,

        // Define the size of EditableImage.
        size: 120.0,

        // Define the position of edit icon.
        editIconPosition: Position.bottomLeft,

        // Define the Theme of image picker.
        imagePickerTheme: ThemeData(
          // Define the default brightness and colors.
          primaryColor: Colors.white,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white70,
          iconTheme: const IconThemeData(color: Colors.black87),
          // Define the default font family.
          fontFamily: 'Georgia',
        ),

        // Define the border of the image if needed.
        imageBorder: Border.all(color: Colors.black87, width: 2.0),

        // Define the border of the icon if needed.
        editIconBorder: Border.all(color: Colors.black87, width: 2.0),
      ),
      );
  }
}