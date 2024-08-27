import 'package:hive/hive.dart';
import 'package:hms_system_application/utils/data_sanitiser.dart';

part 'submission.g.dart';

@HiveType(typeId: 8)
class Submission extends HiveObject {
  @HiveField(0)
  int submissionId;

  @HiveField(1)
  DateTime submissionDate;

  @HiveField(2)
  int assignmentId;

  @HiveField(3)
  int submissionGrade;

  Submission({
    required this.submissionId,
    required this.submissionDate,
    required this.assignmentId,
    required this.submissionGrade,
  });

  factory Submission.fromJson(Map<String, dynamic> json) {
    return Submission(
        submissionId: int.parse(json['id']),
        submissionDate: coalesceDate(json['submission_date']),
        assignmentId: int.parse(json['assignment_id']),
        submissionGrade: int.parse(json['grade']));
  }

  static List<Submission> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => Submission.fromJson(item)).toList();
  }
}
