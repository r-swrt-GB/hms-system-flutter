// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileAdapter extends TypeAdapter<File> {
  @override
  final int typeId = 3;

  @override
  File read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return File(
      fileId: fields[0] as int,
      fileName: fields[1] as String,
      mimeType: fields[2] as String,
      fileExtension: fields[3] as String,
      size: fields[4] as int,
      baseUrl: fields[5] as String,
      fileKey: fields[6] as String,
      thumbnailKey: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, File obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.fileId)
      ..writeByte(1)
      ..write(obj.fileName)
      ..writeByte(2)
      ..write(obj.mimeType)
      ..writeByte(3)
      ..write(obj.fileExtension)
      ..writeByte(4)
      ..write(obj.size)
      ..writeByte(5)
      ..write(obj.baseUrl)
      ..writeByte(6)
      ..write(obj.fileKey)
      ..writeByte(7)
      ..write(obj.thumbnailKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
