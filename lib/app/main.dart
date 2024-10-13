import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hms_system_application/framework/providers/navigation_provider.dart';
import 'package:hms_system_application/framework/router/app_router.dart';
import 'package:hms_system_application/init/app.dart';
import 'package:hms_system_application/theme/theme.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class AppMain extends StatefulWidget {
  final AppRouter router;

  AppMain({super.key, required this.router});

  @override
  State<AppMain> createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
  final theme = appTheme;
  GlobalKey<NavigatorState>? navigatorKey;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        navigatorKey = context.read<NavigationProvider>().key;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    appStartup(context);

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
          onGenerateRoute: widget.router.generateRoute,
          initialRoute: widget.router.defaultRoute,
          navigatorKey: navigatorKey,
        ),
      ),
    );
  }
}
