import 'package:f_logs/model/flog/log_level.dart';

class GenericAppConfig {
  String appName;
  String apiBaseUrl;
  String environmentName;
  bool logDebug;
  String logEncryptionKey;
  List<LogLevel> logLevelsEnabled = const [
    LogLevel.SEVERE,
    LogLevel.ERROR,
    LogLevel.WARNING,
    LogLevel.INFO
  ];

  GenericAppConfig(
      {required this.appName,
        required this.apiBaseUrl,
        required this.environmentName,
        required this.logEncryptionKey,
        required this.logLevelsEnabled,
        this.logDebug = true,
      });
}