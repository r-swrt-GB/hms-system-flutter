// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hms_system_application/models/group.dart';

class GroupProvider with ChangeNotifier {
  final String boxName = "groupBox";
  late List<Group> _group;

  List<Group> get users => _group;

  Future<Box<Group>> getGroupBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<Group>(boxName);
    } else {
      return await Hive.openBox<Group>(boxName);
    }
  }

  Future<Group?> get group async {
    final box = await getGroupBox();
    return box.getAt(0);
  }

  Future<bool> storeGroupDetails(Group? group) async {
    try {
      final box = await getGroupBox();

      if (group != null) {
        await box.clear();
        await box.add(group);

        notifyListeners();
        print('Group saved successfully');
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
