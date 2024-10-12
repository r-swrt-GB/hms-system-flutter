import 'package:get_it/get_it.dart';
import 'package:hms_system_application/framework/router/app_router.dart';
import 'package:hms_system_application/pages/Settings_page.dart';
import 'package:hms_system_application/pages/home_screen.dart';
import 'package:hms_system_application/pages/notifications_page.dart';
import 'package:hms_system_application/pages/sign_in_page.dart';
import 'package:hms_system_application/providers/auth_provider.dart';

registerRoutes(AppRouter router) {
  var authProvider = GetIt.I.get<AuthProvider>();

  router.defaultRoute = '/';

  var authGuard = RouteGuard(
    canAccessRoute: () => authProvider.isLoggedIn,
    onFail: '/login',
  );

  router.materialRoute(
    '/',
    (args) {
      return const SettingsPage();
    },
    routeGuard: authGuard,
  );

  router.materialRoute(
    '/login',
    (args) {
      return const NotificationsPage();
    },
    // routeGuard: authGuard,
  );

  router.materialRoute(
    '/assignments',
    (args) {
      return const AssignmentsPage();
    },
    // routeGuard: authGuard,
  );

  router.materialRoute(
    '/assignment-details',
    (args) {
      return const AssignmentDetailsPage();
    },
    // routeGuard: authGuard,
  );

  router.materialRoute(
    '/submission',
    (args) {
      return const SubmissionPage();
    },
    // routeGuard: authGuard,
  );

  router.materialRoute(
    '/settings',
    (args) {
      return const SettingsPage();
    },
    // routeGuard: authGuard,
  );

  /*router.materialRoute(
    '/',
    (args) {
      if (outletProvider.selectedOutlet == null) {
        return const OutletSelectPage();
      }
      return const HomePage();
    },
    routeGuard: authGuard,
  );

  router.materialRoute('/some-route', (args) => const ExamplePage());

    router.materialRoute('/create-payment', (args) {
    var order = args['order'] as Order;
    return CreatePayment(order: order);
  });


  
  router.materialRoute('/user', (args) => UserPage(args:args),
   routeGuard: authGuard);



  router.createRoute(AppRoute('/test', generator: (args, state) {
    return FadeRoute(builder: (_) => HomePage());
  }));*/
}
