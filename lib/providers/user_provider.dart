// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hms_system_application/models/user.dart';

class UserProvider with ChangeNotifier {
  final String boxName = "userBox";
  late List<User> _users;

  List<User> get users => _users;

  String? _loggedInUserEmail;
  String? get loggedInUserEmail => _loggedInUserEmail;

  Future<Box<User>> getUserBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<User>(boxName);
    } else {
      return await Hive.openBox<User>(boxName);
    }
  }

  Future<User?> get user async {
    final box = await getUserBox();
    return box.getAt(0);
  }

  Future<bool> storeUserDetails(User? user) async {
    try {
      final box = await getUserBox();

      if (user != null) {
        await box.clear();
        await box.add(user);

        notifyListeners();
        print('User saved successfully');
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
