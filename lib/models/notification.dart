import 'package:hive/hive.dart';
import 'package:hms_system_application/utils/data_sanitiser.dart';

part 'notification.g.dart';

@HiveType(typeId: 6)
class Notification extends HiveObject {
  @HiveField(0)
  int notificationId;

  @HiveField(1)
  int userId;

  @HiveField(2)
  int moduleId;

  @HiveField(3)
  String notificationTitle;

  @HiveField(4)
  String notificationType;

  @HiveField(5)
  String notificationMessage;

  Notification({
    required this.notificationId,
    required this.userId,
    required this.moduleId,
    required this.notificationTitle,
    required this.notificationType,
    required this.notificationMessage,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      notificationId: int.parse(json['id']),
      userId: int.parse(json['user_id']),
      moduleId: int.parse(json['module_id']),
      notificationTitle: coalesceString(json['title']),
      notificationType: coalesceString(json['type']),
      notificationMessage: coalesceString(json['message']),
    );
  }

  static List<Notification> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => Notification.fromJson(item)).toList();
  }
}
