import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:image/image.dart' as img;
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

      File compressedFile = await _compressImage(imageFile);

      final directory = await getApplicationDocumentsDirectory();
      final newPath = '${directory.path}/${DateTime.now().toIso8601String()}.png';

      await compressedFile.copy(newPath);

      Box box = await Hive.openBox('images');
      box.put('imagePath', newPath);

      _image = File(newPath);
      notifyListeners();
    } else {
      Fluttertoast.showToast(
        msg: "Фотография не выбрана",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<File> _compressImage(File file) async {
    final Uint8List bytes = await file.readAsBytes();

    // Декодируем изображение
    img.Image? image = img.decodeImage(bytes);
    if (image == null) throw Exception('Не удалось декодировать изображение');

    // Сжимаем изображение (изменяем качество и размер, если нужно)
    final compressedImage = img.encodeJpg(image, quality: 80);

    // Записываем в новый файл
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg');

    await tempFile.writeAsBytes(compressedImage);

    return tempFile;
  }
}
