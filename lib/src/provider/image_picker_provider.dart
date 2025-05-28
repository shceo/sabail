import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sabail/src/data/locale/db.dart';

class ImageNotifier extends ChangeNotifier {
  final AppDatabase _db;
  File? _image;

  File? get image => _image;

  ImageNotifier(this._db) {
    _loadImage();
  }

  Future<void> _loadImage() async {
    final path = await _db.getLastImagePath();
    if (path != null) {
      _image = File(path);
      notifyListeners();
    }
  }

  Future<void> getImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) {
      Fluttertoast.showToast(
        msg: "Фотография не выбрана",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    // Сжимаем
    final originalFile = File(picked.path);
    final compressedFile = await _compressImage(originalFile);

    // Сохраняем в documents
    final dir = await getApplicationDocumentsDirectory();
    final newPath = '${dir.path}/${DateTime.now().toIso8601String()}.jpg';
    await compressedFile.copy(newPath);

    // Пишем в БД Drift
    await _db.addImagePath(newPath);

    // Обновляем состояние
    _image = File(newPath);
    notifyListeners();
  }

  Future<File> _compressImage(File file) async {
    final bytes = await file.readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      throw Exception('Не удалось декодировать изображение');
    }

    final jpgBytes = img.encodeJpg(decoded, quality: 80);
    final tmpDir = await getTemporaryDirectory();
    final tmpFile =
        File('${tmpDir.path}/cmp_${DateTime.now().millisecondsSinceEpoch}.jpg');
    await tmpFile.writeAsBytes(jpgBytes);
    return tmpFile;
  }
}
