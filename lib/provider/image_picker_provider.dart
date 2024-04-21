import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageNotifier with ChangeNotifier {
  File? _image;

  File? get image => _image;

  ImageNotifier() {
    _loadImage();
  }

  Future _loadImage() async {
    Box box = await Hive.openBox('images');
    String? imagePath = box.get('imagePath');
    if (imagePath != null) {
      _image = File(imagePath);
      notifyListeners();
    }
  }

  Future getImage() async {
     final pickedFile = await ImagePicker().pickImage(
    source: ImageSource.gallery, 
  );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      File compressedFile = await FlutterNativeImage.compressImage(
          imageFile.path,
          quality: 80,
          percentage: 80);

      final directory = await getApplicationDocumentsDirectory();

      final File newImage = await compressedFile
          .copy('${directory.path}/${DateTime.now().toIso8601String()}.png');

      Box box = await Hive.openBox('images');

      box.put('imagePath', newImage.path);

      _image = newImage;
      notifyListeners();
    } else {
      Fluttertoast.showToast(
          msg: "Фотография не выбрана",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
