import 'package:get_it/get_it.dart';
import 'package:hms_system_application/routes/routes.dart';

import '../config/app_config.dart';
import '../framework/router/app_router.dart';

AppRouter initRouter(AppConfig appConfig) {
  var router = AppRouter();
  registerRoutes(router);
  GetIt.I.registerSingleton<AppRouter>(router);
  return router;
}
