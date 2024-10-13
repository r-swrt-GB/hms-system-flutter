// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:hms_system_application/models/module.dart';
import 'package:hms_system_application/models/notification_model.dart';
import 'package:hms_system_application/providers/user_provider.dart';

class NotificationProvider extends UserProvider {
  @override
  final String boxName = "notificationsBox";
  late List<NotificationModel> _notifications;

  List<NotificationModel> get notifications => _notifications;

  Future<Box<List<NotificationModel>>> getNotificationBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<List<NotificationModel>>(boxName);
    } else {
      return await Hive.openBox<List<NotificationModel>>(boxName);
    }
  }

  Future<List<NotificationModel>?> get notification async {
    final box = await getNotificationBox();
    return box.getAt(0);
  }

  Future<bool> storeNotificationDetails(NotificationModel? notification) async {
    try {
      final box = await getNotificationBox();

      if (notification != null) {
        await box.clear();
        await box.add(notifications);

        notifyListeners();
        print('Notification saved successfully');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future refreshNotifications(List<Module> modules) async {
    try {
      List<NotificationModel> notificationsList = [];

      if (modules.isEmpty) {
        return;
      }

      for (var i = 0; i < modules.length; i++) {
        Response notificationResponse =
            await api.refreshNotifications(modules[i].moduleId);

        if (notificationResponse.statusCode == 200 &&
            notificationResponse.data['notifications'] != null) {
          for (var k = 0;
              k < notificationResponse.data['notifications'].length;
              k++) {
            notificationsList.add(NotificationModel.fromJson(
                notificationResponse.data['notifications'][k]));
          }
        }
      }

      _notifications = notificationsList;
    } catch (ex) {
      rethrow;
    } finally {
      stopLoading();
      notifyListeners();
    }
  }
}
