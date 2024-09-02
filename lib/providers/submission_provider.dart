// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hms_system_application/models/submission.dart';

class SubmissionProvider with ChangeNotifier {
  final String boxName = "submissionBox";
  late List<Submission> _submission;

  List<Submission> get users => _submission;

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

  Future<bool> storeCandidateDetails(Submission? submission) async {
    try {
      final box = await getSubmissionBox();

      if (submission != null) {
        await box.clear();
        await box.add(submission);

        notifyListeners();
        print('submission saved successfully');
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