import 'dart:async';

import 'package:starter_application/models/user.dart';
import 'package:starter_application/providers/app/app_provider.dart';

class AuthProvider extends AppProvider<AuthProvider> {
  bool get isLoggedIn {
    return token != null;
  }

  User? get user {
    return boxStore.getBox<User>('user').get('user');
  }

  set user(User? value) {
    if (value == null) return;
    boxStore.getBox<User>('user').put('user', value);
  }

  String? get token {
    return boxStore.getBox<String?>('auth_token').get('token');
  }

  set token(String? value) {
    boxStore.getBox<String?>('auth_token').put('token', value);
  }

  Future<void> logout() async {
    token = null;
  }

  Future login(String email, String password) async {
    try {
      startLoading();
      var response = await api.performLogin(email, password);
      token = response.data['access_token'];
      await refreshUser();
    } catch (ex) {
      rethrow;
    } finally {
      stopLoading();
      notifyListeners();
    }
  }

  Future register(String email, String password) async {
    try {
      startLoading();
      await api.performRegistration(email, password);
      var loginResponse = await api.performLogin(email, password);
      token = loginResponse.data['access_token'];
      await refreshUser();
    } catch (exception) {
      rethrow;
    } finally {
      stopLoading();
      notifyListeners();
    }
  }

  Future refreshUser() async {
    try {
      startLoading();
      var userResponse = await api.refreshUser();
      user = User.fromJson(userResponse.data);
    } catch (ex) {
      rethrow;
    } finally {
      stopLoading();
      notifyListeners();
    }
  }

  Future deleteUser(int userId, String userEmail) async {
    try {
      startLoading();
      await api.deleteUser(userId, userEmail, token!);
      await logout();
    } catch (ex) {
      rethrow;
    } finally {
      stopLoading();
      notifyListeners();
    }
  }

  Map<String, String> getAuthHeaders() {
    return {
      'Authorization': 'Bearer $token',
    };
  }

  bool getEmployeeCreatedOrderStatus(int orderId) {
    return (user?.userId == orderId);
  }
}
