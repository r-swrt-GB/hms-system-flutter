import 'package:flutter/material.dart';
import 'package:hms_system_application/framework/providers/navigation_provider.dart';
import 'package:hms_system_application/framework/providers/provider_registration.dart';
import 'package:hms_system_application/providers/auth_provider.dart';

class InitProviders extends ProviderRegistration {
  @override
  Future<void> providers() async {
    registerProvider<NavigationProvider>(
      NavigationProvider(GlobalKey<NavigatorState>()),
    );
    registerProvider<AuthProvider>(AuthProvider());
  }
}
