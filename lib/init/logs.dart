import 'package:f_logs/model/flog/flog.dart';
import 'package:starter_application/config/app_config.dart';

void initLogs(AppConfig appConfig) {
  var config = FLog.getDefaultConfigurations()
    ..logLevelsEnabled = appConfig.logLevelsEnabled
    ..isDevelopmentDebuggingEnabled = appConfig.logDebug
    ..isDebuggable = appConfig.logDebug
    ..encryptionEnabled = appConfig.logEncryptionKey != ""
    ..encryptionKey = appConfig.logEncryptionKey;
  FLog.applyConfigurations(config);
}
