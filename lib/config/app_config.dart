import 'package:hms_system_application/framework/config/generic_app_config.dart';

class AppConfig extends GenericAppConfig {
  String pushApiKey;

  AppConfig({
    required super.appName,
    required super.apiBaseUrl,
    required super.environmentName,
    required super.logEncryptionKey,
    required super.logLevelsEnabled,
    required super.logDebug,
    required this.pushApiKey,
  });
}
