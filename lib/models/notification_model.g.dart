// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationModelAdapter extends TypeAdapter<NotificationModel> {
  @override
  final int typeId = 7;

  @override
  NotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationModel(
      notificationId: fields[0] as int,
      userId: fields[1] as int,
      moduleId: fields[2] as int,
      notificationTitle: fields[3] as String,
      notificationType: fields[4] as String,
      notificationMessage: fields[5] as String,
      readAt: fields[6] as DateTime?,
      createdAt: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.notificationId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.moduleId)
      ..writeByte(3)
      ..write(obj.notificationTitle)
      ..writeByte(4)
      ..write(obj.notificationType)
      ..writeByte(5)
      ..write(obj.notificationMessage)
      ..writeByte(6)
      ..write(obj.readAt)
      ..writeByte(7)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
