// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hms_system_application/models/assignment.dart';

class AssignmentProvider with ChangeNotifier {
  final String boxName = "assignmentBox";
  late List<Assignment> _assignments;

  List<Assignment> get assignments => _assignments;

  Future<Box<Assignment>> getAssignmentBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<Assignment>(boxName);
    } else {
      return await Hive.openBox<Assignment>(boxName);
    }
  }

  Future<Assignment?> get assignment async {
    final box = await getAssignmentBox();
    return box.getAt(0);
  }

  Future<bool> storeAssignmentDetails(Assignment? assignment) async {
    try {
      final box = await getAssignmentBox();

      if (assignment != null) {
        await box.clear();
        await box.add(assignment);

        notifyListeners();
        print('Assignment saved successfully');
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
