import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:hms_system_application/models/module.dart';
import 'package:hms_system_application/providers/user_provider.dart';

class ModuleProvider extends UserProvider {
  @override
  final String boxName = "modulesBox";
  List<Module> _modules = [];

  List<Module> get modules => _modules;

  Future<Box<List<Module>>> getModulesBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<List<Module>>(boxName);
    } else {
      return await Hive.openBox<List<Module>>(boxName);
    }
  }

  Future<List<Module>?> get module async {
    final box = await getModulesBox();
    return box.getAt(0);
  }

  Future<bool> storeModulesDetails(List<Module>? modules) async {
    try {
      final box = await getModulesBox();

      if (modules != null) {
        await box.clear();
        await box.add(modules);

        notifyListeners();
        print('Module saved successfully');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future refreshModules() async {
    try {
      startLoading();
      Response moduleResponse = await api.refreshModules();

      List<Module> moduleList = [];

      if (moduleResponse.statusCode == 200) {
        for (var i = 0; i < moduleResponse.data['modules'].length; i++) {
          moduleList.add(Module.fromJson(moduleResponse.data['modules'][i]));
        }

        _modules = moduleList;
      }
    } catch (ex) {
      rethrow;
    } finally {
      stopLoading();
      notifyListeners();
    }
  }
}
