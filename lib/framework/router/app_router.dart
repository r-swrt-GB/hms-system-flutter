import 'package:flutter/material.dart';

import 'route_animation_types.dart';

class AppRouter {
  String defaultRoute;
  late Map<String, AppRoute> routes;

  AppRouter({this.defaultRoute = '/', Map<String, AppRoute>? routes}) {
    this.routes = routes ?? {};
  }

  void createRoute(AppRoute route) {
    routes[route.routeName] = route;
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    String routeName = '/';

    if (routes.containsKey(settings.name)) {
      routeName = settings.name ?? '/';
    } else if (!routes.containsKey(routeName)) {
      throw RouteNotSpecifiedException();
    }

    AppRoute route = routes[routeName] as AppRoute;

    if (route.routeGuard != null) {
      if (!route.routeGuard!.canAccessRoute()) {
        assert(routes.containsKey(route.routeGuard?.onFail));
        route = routes[route.routeGuard!.onFail] as AppRoute;
      }
    }

    return route.generator!(args);
  }

  void addAll(List<AppRoute> routeList) {
    for (var route in routeList) {
      routes[route.routeName] = route;
    }
  }

  void fadeRoute(String routeName, AppRoutePageCreator page,
      {RouteGuard? routeGuard}) {
    var route = AppRoute(routeName, routeGuard: routeGuard, generator: (args) {
      return FadeRoute(builder: (context) => page(args));
    });
    routes[route.routeName] = route;
  }

  void plainRoute(String routeName, AppRoutePageCreator page,
      {RouteGuard? routeGuard}) {
    var route = AppRoute(routeName, routeGuard: routeGuard, generator: (args) {
      return NoAnimation(builder: (context) => page(args));
    });
    routes[route.routeName] = route;
  }

  void materialRoute(String routeName, AppRoutePageCreator page,
      {RouteGuard? routeGuard}) {
    var route = AppRoute(routeName, routeGuard: routeGuard, generator: (args) {
      return MaterialPageRoute(builder: (context) => page(args));
    });
    routes[route.routeName] = route;
  }
}

typedef AppRoutePageCreator = dynamic Function(dynamic args);

typedef AppRouteGenerator = Route<dynamic> Function(dynamic args);

class AppRoute {
  String routeName;
  RouteGuard? routeGuard;
  AppRouteGenerator? generator;

  AppRoute(this.routeName, {this.routeGuard, @required this.generator});
}

typedef GuardFunction<S> = bool Function();

class RouteGuard<T> {
  final GuardFunction<T> canAccessRoute;
  final String onFail;

  RouteGuard({required this.onFail, required this.canAccessRoute});
}

class RouteNotSpecifiedException implements Exception {}
