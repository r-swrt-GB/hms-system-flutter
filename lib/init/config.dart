import 'package:f_logs/model/flog/log_level.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../config/app_config.dart';

Future<AppConfig> getEnvironmentConfig({envFilename = '.env'}) async {
  await dotenv.load(fileName: envFilename);

  return AppConfig(
      appName: dotenv.get('APP_NAME', fallback: 'App'),
      apiBaseUrl: dotenv.get('BASE_URL', fallback: '[URL]'),
      environmentName: dotenv.get('ENVIRONMENT', fallback: 'dev'),
      logEncryptionKey: '',
      pushApiKey: '',
      logDebug: dotenv.get('DEBUG', fallback: 'false') == 'true',
      logLevelsEnabled: dotenv.get('DEBUG', fallback: 'false') == 'true'
          ? [LogLevel.SEVERE, LogLevel.ERROR, LogLevel.WARNING, LogLevel.INFO]
          : []);
}
