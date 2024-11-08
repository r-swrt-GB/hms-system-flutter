// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModuleAdapter extends TypeAdapter<Module> {
  @override
  final int typeId = 6;

  @override
  Module read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Module(
      moduleId: fields[0] as int,
      moduleName: fields[1] as String,
      moduleCode: fields[2] as String,
      moduleDescription: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Module obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.moduleId)
      ..writeByte(1)
      ..write(obj.moduleName)
      ..writeByte(2)
      ..write(obj.moduleCode)
      ..writeByte(3)
      ..write(obj.moduleDescription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModuleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
