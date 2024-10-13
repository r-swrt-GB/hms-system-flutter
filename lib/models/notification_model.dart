import 'package:hive/hive.dart';
import 'package:hms_system_application/utils/data_sanitiser.dart';

part 'notification_model.g.dart';

@HiveType(typeId: 7)
class NotificationModel extends HiveObject {
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

  NotificationModel({
    required this.notificationId,
    required this.userId,
    required this.moduleId,
    required this.notificationTitle,
    required this.notificationType,
    required this.notificationMessage,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['id'],
      userId: json['user_id'],
      moduleId: json['module_id'],
      notificationTitle: coalesceString(json['title']),
      notificationType: coalesceString(json['type']),
      notificationMessage: coalesceString(json['message']),
    );
  }

  static List<NotificationModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => NotificationModel.fromJson(item)).toList();
  }
}
