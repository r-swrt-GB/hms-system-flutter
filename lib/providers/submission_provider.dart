// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:hms_system_application/models/assignment.dart';
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

  Future<List?> getSubmissionsForAssignment(
      int moduleId, int assigmentId) async {
    try {
      List? submissions = await api.getSubmissions(moduleId, assigmentId);
      return submissions;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> uploadSubmission(Assignment assignment, List files) async {
    try {
      Response submissionResponse = await api.uploadSubmission(
          assignment.moduleId, assignment.assignmentId, files);
      notifyListeners();
      print('Submission saved successfully');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String?> fetchPresignedUrl(String moduleId, String assignmentId,
      String fileName, String contentType) async {
    try {
      String? url = await api.fetchPresignedUrl(
          moduleId, assignmentId, fileName, contentType);
      notifyListeners();
      print('URL Fetched successfully');
      return url;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> uploadFileToS3(
      String presignedUrl, File file, String contentType) async {
    try {
      bool submissionResponse =
          await api.uploadFileToS3(presignedUrl, file, contentType);
      notifyListeners();
      print('Submission saved successfully');
      return submissionResponse;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
