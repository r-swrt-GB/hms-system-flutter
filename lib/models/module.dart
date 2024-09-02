import 'package:hive/hive.dart';
import 'package:hms_system_application/utils/data_sanitiser.dart';

part 'module.g.dart';

@HiveType(typeId: 6)
class Module extends HiveObject {
  @HiveField(0)
  int moduleId;

  @HiveField(1)
  String moduleName;

  @HiveField(2)
  String moduleCode;

  @HiveField(3)
  String moduleDescription;

  Module({
    required this.moduleId,
    required this.moduleName,
    required this.moduleCode,
    required this.moduleDescription,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      moduleId: int.parse(json['id']),
      moduleName: coalesceString(json['module_name']),
      moduleCode: coalesceString(json['code']),
      moduleDescription: coalesceString(json['description']),
    );
  }

  static List<Module> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => Module.fromJson(item)).toList();
  }
}
