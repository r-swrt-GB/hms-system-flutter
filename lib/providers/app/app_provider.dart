import 'package:get_it/get_it.dart';
import 'package:starter_application/framework/providers/generic_app_provider.dart';
import 'package:starter_application/services/api_service.dart';

import '../../framework/providers/navigation_provider.dart';

abstract class AppProvider<T> extends GenericAppProvider<T> {
  bool loading = false;

  NavigationProvider get navigationProvider => resolve<NavigationProvider>();

  ApiService get api {
    return GetIt.I.get<ApiService>();
  }

  startLoading() {
    loading = true;
    notifyListeners();
  }

  stopLoadingAndNotify() {
    loading = false;
    notifyListeners();
  }

  stopLoading() {
    loading = false;
  }
}
