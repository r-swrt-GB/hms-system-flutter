import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:hms_system_application/framework/providers/navigation_provider.dart';
import 'package:hms_system_application/framework/router/app_router.dart';
import 'package:hms_system_application/theme/theme.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class AppMain extends StatefulWidget {
  final AppRouter router;

  const AppMain({super.key, required this.router});

  @override
  _AppMainState createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
  final theme = appTheme;
  int _selectedIndex = 0;

  // Define routes for each tab
  final List<String> _tabRoutes = [
    '/assignments',
    '/notifications',
    '/settings',
  ];

  @override
  Widget build(BuildContext context) {
    final appRouter = GetIt.I<AppRouter>();

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
          navigatorKey: context.read<NavigationProvider>().key,
          home: Scaffold(
            body: IndexedStack(
              index: _selectedIndex,
              children: _tabRoutes.map((route) {
                return Navigator(
                  onGenerateRoute: (settings) {
                    return appRouter.generateRoute(
                      RouteSettings(
                        name: route,
                        arguments: const {},
                      ),
                    );
                  },
                  onPopPage: (route, result) {
                    if (!route.didPop(result)) {
                      return false;
                    }
                    setState(() {});
                    return true;
                  },
                );
              }).toList(),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: theme.primaryColor,
              unselectedItemColor: Colors.grey,
              currentIndex: _selectedIndex,
              onTap: (index) {
                if (_selectedIndex != index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.file_copy),
                  label: 'Assignments',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Notifications',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
