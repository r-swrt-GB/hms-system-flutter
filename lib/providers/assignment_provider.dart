// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:hms_system_application/models/assignment.dart';
import 'package:hms_system_application/models/module.dart';
import 'package:hms_system_application/providers/user_provider.dart';

class AssignmentProvider extends UserProvider {
  @override
  final String boxName = "assignmentsBox";
  List<Assignment> _assignments = [];

  List<Assignment> get assignments => _assignments;

  Future<Box<List<Assignment>>> getAssignmentsBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<List<Assignment>>(boxName);
    } else {
      return await Hive.openBox<List<Assignment>>(boxName);
    }
  }

  Future<List<Assignment>?> get assignment async {
    final box = await getAssignmentsBox();
    return box.getAt(0);
  }

  Future refreshAssignments(List<Module> modules) async {
    try {
      List<Assignment> assignmentList = [];

      if (modules.isEmpty) {
        return;
      }

      for (var i = 0; i < modules.length; i++) {
        Response assignmentResponse =
            await api.refreshAssigments(modules[i].moduleId);

        if (assignmentResponse.statusCode == 200 &&
            assignmentResponse.data['assignments'] != null) {
          for (var k = 0;
              k < assignmentResponse.data['assignments'].length;
              k++) {
            assignmentList.add(
                Assignment.fromJson(assignmentResponse.data['assignments'][k]));
          }
        }
      }

      _assignments = assignmentList;
    } catch (ex) {
      rethrow;
    } finally {
      stopLoading();
      notifyListeners();
    }
  }
}
