import 'package:hive/hive.dart';

class BoxStore {
  Map<String, Box> boxes = {};

  openBox<T>(name) async {
    Box box = await Hive.openBox<T>(name);
    boxes[name] = box;
  }

  Box<T> getBox<T>(name) {
    return boxes[name] as Box<T>;
  }

  closeBox(name) async {
    await boxes[name]?.close();
  }
 
  openEncryptedBox<T>(name) {
    //TODO
  }
}
