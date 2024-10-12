import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:hms_system_application/models/user.dart';
import 'package:hms_system_application/providers/app/app_provider.dart';

class UserProvider extends AppProvider<UserProvider> {
  final String boxName = "userBox";

  String? _loggedInUserEmail;
  String? get loggedInUserEmail => _loggedInUserEmail;

  Future<Box<User>> getUserBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<User>(boxName);
    } else {
      return await Hive.openBox<User>(boxName);
    }
  }

  Future<User?> get user async {
    print("HI!");
    final box = await getUserBox();
    return box.getAt(0);
  }

  Future<bool> storeUserDetails(User? user) async {
    try {
      final box = await getUserBox();

      if (user != null) {
        // Store to backend
        Response response = await api.updateuser(user);

        if (response.statusCode == 200 || response.statusCode == 201) {
          // Store locally
          await box.clear();
          await box.add(user);

          notifyListeners();
          print('User saved successfully');
          return true;
        } else {
          print('Failed to save user');
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
