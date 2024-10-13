import 'package:hive/hive.dart';
import 'package:hms_system_application/utils/data_sanitiser.dart';

part 'assignment.g.dart';

@HiveType(typeId: 4)
class Assignment extends HiveObject {
  @HiveField(0)
  int assignmentId;

  @HiveField(1)
  String assignmentTitle;

  @HiveField(2)
  String assignmentDescription;

  @HiveField(3)
  int minVideos;

  @HiveField(4)
  int maxVideos;

  @HiveField(5)
  int maxVideoLength;

  @HiveField(6)
  int maxGrade;

  @HiveField(7)
  DateTime openDate;

  @HiveField(8)
  DateTime dueDate;

  @HiveField(9)
  int moduleId;

  Assignment({
    required this.assignmentId,
    required this.moduleId,
    required this.assignmentTitle,
    required this.assignmentDescription,
    required this.minVideos,
    required this.maxVideos,
    required this.maxVideoLength,
    required this.maxGrade,
    required this.openDate,
    required this.dueDate,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      assignmentId: json['id'],
      moduleId: json['module_id'],
      assignmentTitle: coalesceString(json['title']),
      assignmentDescription: coalesceString(json['description']),
      minVideos: json['min_videos'],
      maxVideos: json['max_videos'],
      maxVideoLength: json['max_video_length'],
      maxGrade: json['max_grade'],
      openDate: coalesceDate(json['open_date']),
      dueDate: coalesceDate(json['due_date']),
    );
  }

  static List<Assignment> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => Assignment.fromJson(item)).toList();
  }
}
