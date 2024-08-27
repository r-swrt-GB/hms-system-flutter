import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hms_system_application/store/box_store.dart';

abstract class GenericAppProvider<T> extends ChangeNotifier {
  BoxStore get boxStore {
    return GetIt.I.get<BoxStore>();
  }

  Box<T> getBox<T>(name) {
    return boxStore.getBox<T>(name);
  }

  T resolve<T extends Object>() {
    return GetIt.I.get<T>();
  }
}
