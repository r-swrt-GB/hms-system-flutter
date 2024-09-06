import 'package:hive/hive.dart';
import 'package:hms_system_application/utils/data_sanitiser.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  int userId;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String lastName;

  @HiveField(3)
  String email;

  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'],
      firstName: coalesceString(json['first_name']),
      lastName: coalesceString(json['last_name']),
      email: coalesceString(json['email']),
    );
  }

  static List<User> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => User.fromJson(item)).toList();
  }
}
