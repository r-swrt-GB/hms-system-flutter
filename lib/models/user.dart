import 'package:hive/hive.dart';
import 'package:hms_system_application/utils/data_sanitiser.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String? email;

  @HiveField(2)
  int userId;

  User({
    required this.name,
    required this.email,
    required this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: coalesceString(json['name']),
      email: coalesceString(json['email']),
      userId: int.parse(json['userid'].toString()),
    );
  }

  static List<User> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => User.fromJson(item)).toList();
  }
}
