import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

abstract class ProviderRegistration {

  List<SingleChildWidget> changeNotifierProviders = [];

  registerProviderAsync<T extends ChangeNotifier>(provider) async {
    final getIt = GetIt.instance;
    getIt.registerSingleton<T>(await provider);
    changeNotifierProviders.add(ChangeNotifierProvider<T>(create: (_)=>getIt.get<T>()));
  }

  registerProvider<T extends ChangeNotifier>(provider) {
    final getIt = GetIt.instance;
    getIt.registerSingleton<T>(provider);
    changeNotifierProviders.add(ChangeNotifierProvider<T>(create: (_)=>getIt.get<T>()));
  }

  Future<void> providers();

  MultiProvider multiProvider(Widget child) {
    return MultiProvider(providers: changeNotifierProviders, child: child,);
  }

}