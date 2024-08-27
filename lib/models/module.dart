import 'package:hive/hive.dart';
import 'package:starter_application/utils/data_sanitiser.dart';

part 'module.g.dart';

@HiveType(typeId: 6)
class Module extends HiveObject {
  @HiveField(0)
  int moduleId;

  @HiveField(1)
  String module_name;

  @HiveField(2)
  String module_code;

  @HiveField(3)
  String module_description;

  Module({
    required this.moduleId,
    required this.module_name,
    required this.module_code,
    required this.module_description,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      moduleId: int.parse(json['id']),
      module_name: coalesceString(json['module_name']),
      module_code: coalesceString(json['code']),
      module_description: coalesceString(json['description']),
    );
  }

  static List<Module> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => Module.fromJson(item)).toList();
  }
}
