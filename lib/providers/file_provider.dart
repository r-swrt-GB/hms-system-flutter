// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hms_system_application/models/file.dart';

class FileProvider with ChangeNotifier {
  final String boxName = "fileBox";
  late List<File> _files;

  List<File> get files => _files;

  Future<Box<File>> getFileBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<File>(boxName);
    } else {
      return await Hive.openBox<File>(boxName);
    }
  }

  Future<File?> get file async {
    final box = await getFileBox();
    return box.getAt(0);
  }

  Future<bool> storeFileDetails(File? file) async {
    try {
      final box = await getFileBox();

      if (file != null) {
        await box.clear();
        await box.add(file);

        notifyListeners();
        print('File saved successfully');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
