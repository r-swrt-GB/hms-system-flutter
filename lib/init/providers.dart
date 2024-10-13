import 'package:flutter/material.dart';
import 'package:hms_system_application/framework/providers/navigation_provider.dart';
import 'package:hms_system_application/framework/providers/provider_registration.dart';
import 'package:hms_system_application/providers/assignment_provider.dart';
import 'package:hms_system_application/providers/auth_provider.dart';
import 'package:hms_system_application/providers/module_provider.dart';
import 'package:hms_system_application/providers/notification_provider.dart';
import 'package:hms_system_application/providers/user_provider.dart';

class InitProviders extends ProviderRegistration {
  @override
  Future<void> providers() async {
    registerProvider<NavigationProvider>(
      NavigationProvider(GlobalKey<NavigatorState>()),
    );
    registerProvider<AuthProvider>(AuthProvider());
    registerProvider<UserProvider>(UserProvider());
    registerProvider<ModuleProvider>(ModuleProvider());
    registerProvider<AssignmentProvider>(AssignmentProvider());
    registerProvider<NotificationProvider>(NotificationProvider());
  }
}
