// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hms_system_application/models/module.dart';

class ModuleProvider with ChangeNotifier {
  final String boxName = "moduleBox";
  late List<Module> _module;

  List<Module> get users => _module;

  Future<Box<Module>> getModuleBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<Module>(boxName);
    } else {
      return await Hive.openBox<Module>(boxName);
    }
  }

  Future<Module?> get module async {
    final box = await getModuleBox();
    return box.getAt(0);
  }

  Future<bool> storeModuleDetails(Module? module) async {
    try {
      final box = await getModuleBox();

      if (module != null) {
        await box.clear();
        await box.add(module);

        notifyListeners();
        print('Module saved successfully');
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
