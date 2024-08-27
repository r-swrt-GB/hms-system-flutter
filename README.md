- Copy lib file to new project
- Copy dependencies and dev dependencies to new project's pubspec
- Copy .env and .env.dev to new project
  - For android emulator use 10.0.2.2:8000 instead of localhost:8000

1. Change name of application in lib/app/main.dart
2. Change theme of application in lib/theme/theme.dart
3. Add adapters to lib/init/adapters.dart
4. Add boxes to regsiter in lib/init/framework.dart
5. Add providers to lib/init/providers.dart
6. Set routes and auth guards in lib/routes/routes.dart
7. Set API's in lib/services/api_service.dart
8. Set desired widgets in lib/services/feedback_service.dart
9. Set menu item in lib/widgets/menu_drawer.dart
10. Add logo to "assets/images/logo.png"
11. Add Models to lib/models/
    11.2 Add "part '<model-name>.g.dart';" to the top of file to generate serialized files
    11.3 Run "dart run build_runner build" to generate .g.dart files
12. Change title in lib/app/main.dart

# -- Last updated 31 March 2024 -- Rikus Swart
