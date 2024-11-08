import 'dart:io';

import 'package:f_logs/f_logs.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hms_system_application/models/assignment.dart';
import 'package:hms_system_application/models/comment.dart';
import 'package:hms_system_application/models/group.dart';
import 'package:hms_system_application/models/module.dart';
import 'package:hms_system_application/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:hms_system_application/config/app_config.dart';
import 'package:hms_system_application/framework/services/http.dart';
import 'package:hms_system_application/init/adapters.dart';
import 'package:hms_system_application/init/boxes.dart';
import 'package:hms_system_application/init/providers.dart';
import 'package:hms_system_application/services/api_service.dart';
import 'package:hms_system_application/store/box_store.dart';

class Framework {
  late InitProviders _initProviders;
  AppConfig config;

  Framework({required this.config});

  Future<Framework> init() async {
    //Init data
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    registerAdapters();

    //Open boxes
    BoxStore boxStore = await _openBoxes(getInitialBoxes());

    //Init Services
    _initServices(boxStore);

    //Init Providers
    _initProviders = InitProviders();
    await _initProviders.providers();

    return this;
  }

  Future<BoxStore> _openBoxes(List boxNames) async {
    BoxStore store = BoxStore();
    await store.openBox<String?>('auth_token');
    await store.openBox<User>('user');
    await store.openBox<File>('file');
    await store.openBox<Assignment>('assignmentsBox');
    await store.openBox<Comment>('commentBox');
    await store.openBox<Group>('groupBox');
    await store.openBox<Module>('modulesBox');
    await store.openBox<Notification>('notificationsBox');
    // await store.openBox('general');

    GetIt.I.registerSingleton<BoxStore>(store);

    return store;
  }

  _initServices(BoxStore boxStore) {
    GetIt.I.registerSingleton<Http>(_initHttp(boxStore));

    GetIt.I.registerSingleton<ApiService>(ApiService());
  }

  _initHttp(BoxStore boxStore) {
    return Http(boxStore.getBox('auth_token'), endPoint: config.apiBaseUrl,
        onAuthFailedResponse: (Box box) {
      box.put('auth_token', null);
      FLog.info(text: "Token expired - Token cleared");
    });
  }

  MultiProvider multiProvider(Widget child) {
    return _initProviders.multiProvider(child);
  }
}
