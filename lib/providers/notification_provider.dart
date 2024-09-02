// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NotificationProvider with ChangeNotifier {
  final String boxName = "notificationBox";
  late List<Notification> _notification;

  List<Notification> get notifications => _notification;

  Future<Box<Notification>> getNotificationBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<Notification>(boxName);
    } else {
      return await Hive.openBox<Notification>(boxName);
    }
  }

  Future<Notification?> get notification async {
    final box = await getNotificationBox();
    return box.getAt(0);
  }

  Future<bool> storeNotificationDetails(Notification? notification) async {
    try {
      final box = await getNotificationBox();

      if (notification != null) {
        await box.clear();
        await box.add(notification);

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
}