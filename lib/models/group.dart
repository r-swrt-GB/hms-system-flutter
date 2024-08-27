import 'package:hive/hive.dart';
import 'package:hms_system_application/utils/data_sanitiser.dart';

part 'group.g.dart';

@HiveType(typeId: 5)
class Group extends HiveObject {
  @HiveField(0)
  int groupID;

  @HiveField(1)
  String groupTitle;

  @HiveField(2)
  String assignmentID;

  Group({
    required this.groupID,
    required this.groupTitle,
    required this.assignmentID,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      groupID: int.parse(json['id']),
      groupTitle: coalesceString(json['first_name']),
      assignmentID: coalesceString(json['last_name']),
    );
  }

  static List<Group> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => Group.fromJson(item)).toList();
  }
}
