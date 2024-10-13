import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hms_system_application/framework/router/app_router.dart';

class CentralPage extends StatefulWidget {
  const CentralPage({super.key});

  @override
  State<CentralPage> createState() => _CentralPageState();
}

class _CentralPageState extends State<CentralPage> {
  int _selectedIndex = 0;

  final List<String> _tabRoutes = [
    '/assignments',
    '/notifications',
    '/settings',
  ];

  @override
  Widget build(BuildContext context) {
    final appRouter = GetIt.I<AppRouter>();

    List<BottomNavigationBarItem> buttonBarItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.file_copy),
        label: 'Assignments',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.notifications),
        label: 'Notifications',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
      ),
    ];

    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: (index) {
            if (_selectedIndex != index) {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
          items: buttonBarItems,
        ),
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
      ),
    );
  }
}
