import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  GlobalKey<NavigatorState> key;

  NavigationProvider(this.key);

  pop() {
    key.currentState?.pop();
  }

  pushNamed(String routeName, {Object? arguments}) {
    key.currentState?.pushNamed(routeName, arguments: arguments);
  }

  pushReplacementNamed(String routeName, {Object? arguments}) {
    key.currentState?.pushReplacementNamed(routeName, arguments: arguments);
  }

  pushNamedAndRemoveUntil(String routeName, RoutePredicate predicate) {
    key.currentState?.pushNamedAndRemoveUntil(routeName, predicate);
  }

  push<T>(Route<T> route) {
    key.currentState?.push(route);
  }

  pushReplacement<T>(Route<T> route) {
    key.currentState?.pushReplacement(route);
  }

  pushAndRemoveUntil<T>(Route<T> route, RoutePredicate predicate) {
    key.currentState?.pushAndRemoveUntil(route, predicate);
  }
}
