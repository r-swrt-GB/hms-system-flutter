// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hms_system_application/models/submission.dart';
import 'package:hms_system_application/providers/user_provider.dart';

class SubmissionProvider extends UserProvider {
  @override
  final String boxName = "submissionBox";
  late List<Submission> _submission;

  List<Submission> get submissions => _submission;

  Future<Box<Submission>> getSubmissionBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<Submission>(boxName);
    } else {
      return await Hive.openBox<Submission>(boxName);
    }
  }

  Future<Submission?> get submission async {
    final box = await getSubmissionBox();
    return box.getAt(0);
  }

  Future<bool> storeSubmissionDetails(
      int moduleId, int assignmentId, List files) async {
    try {
      final box = await getSubmissionBox();

      api.uploadFiles(moduleId, assignmentId, files);
      print('submission saved successfully');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
