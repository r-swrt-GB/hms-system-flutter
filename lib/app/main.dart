import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hms_system_application/framework/providers/navigation_provider.dart';
import 'package:hms_system_application/framework/router/app_router.dart';
import 'package:hms_system_application/theme/theme.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class AppMain extends StatelessWidget {
  final AppRouter router;

  AppMain({super.key, required this.router});

  final theme = appTheme;

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.black,
      overlayWidgetBuilder: (context) => SpinKitWave(
        color: theme.primaryColor,
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MaterialApp(
          title: 'HMS System Flutter',
          theme: theme,
          onGenerateRoute: router.generateRoute,
          initialRoute: router.defaultRoute,
          navigatorKey: context.read<NavigationProvider>().key,
        ),
      ),
    );
  }
}
