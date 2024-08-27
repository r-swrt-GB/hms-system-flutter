import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hms_system_application/app/main.dart';
import 'package:hms_system_application/framework/router/app_router.dart';
import 'package:hms_system_application/init/router.dart';
import 'package:hms_system_application/pages/splash_screen.dart';
import 'package:hms_system_application/providers/auth_provider.dart';
import 'package:hms_system_application/utils/environment_config.dart';

import 'config.dart';
import 'framework.dart';
import 'logs.dart';

void initApp({String envFile = '.env.dev'}) async {
  WidgetsFlutterBinding.ensureInitialized;

  runApp(const SplashScreen());

  var config = await getEnvironmentConfig(envFilename: envFile);
  setAppConfig(config);
  initLogs(config);

  Framework framework = await Framework(config: config).init();

  AppRouter router = initRouter(config);

  await appStartup();

  runApp(
    framework.multiProvider(
      AppMain(
        router: router,
      ),
    ),
  );
}

Future<void> appStartup() async {
  var authProvider = GetIt.I.get<AuthProvider>();

  await Future.delayed(const Duration(seconds: 2));

  if (!authProvider.isLoggedIn) {
    return;
  }

  await authProvider.refreshUser();
}
