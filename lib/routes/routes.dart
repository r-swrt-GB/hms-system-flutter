import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hms_system_application/app/main.dart';
import 'package:hms_system_application/framework/router/app_router.dart';
import 'package:hms_system_application/models/assignment.dart';
import 'package:hms_system_application/models/submission.dart';
import 'package:hms_system_application/pages/Settings_page.dart';
import 'package:hms_system_application/pages/assigments_page.dart';
import 'package:hms_system_application/pages/assignment_page.dart';
import 'package:hms_system_application/pages/central_page.dart';
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
    '/central',
    (args) {
      return const CentralPage();
    },
    routeGuard: authGuard,
  );

  router.materialRoute(
    '/',
    (args) {
      return AppMain(
        router: router,
      );
    },
    routeGuard: authGuard,
  );

  router.materialRoute(
    '/login',
    (args) {
      return const SignInPage();
    },
    routeGuard: authGuard,
  );

  router.materialRoute(
    '/assignments',
    (args) {
      return const AssignmentPage();
    },
    routeGuard: authGuard,
  );

  // router.materialRoute(
  //   '/assignment-details',
  //   (args) {
  //     Assignment assignment = args['assignment'];
  //     return AssigmentsPage(
  //       assignment: assignment,
  //     );
  //   },
  //   routeGuard: authGuard,
  // );

  router.materialRoute(
    '/assignment-details',
    (args) {
      Assignment? assignment = args['assignment'];
      Submission? submission = args['submission'];
      if (assignment != null) {
        return AssigmentsPage(
          assignment: assignment,
          submission: submission,
        );
      } else {
        return const Center(child: Text('Assignment not available'));
      }
    },
    routeGuard: authGuard,
  );

  router.materialRoute(
    '/notifications',
    (args) {
      return const NotificationsPage();
    },
    routeGuard: authGuard,
  );

  router.materialRoute(
    '/settings',
    (args) {
      return const SettingsPage();
    },
    routeGuard: authGuard,
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
