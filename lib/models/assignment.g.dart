// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssignmentAdapter extends TypeAdapter<Assignment> {
  @override
  final int typeId = 4;

  @override
  Assignment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Assignment(
      assignmentId: fields[0] as int,
      assignmentTitle: fields[1] as String,
      assignmentDescription: fields[2] as String,
      minVideos: fields[3] as int,
      maxVideos: fields[4] as int,
      maxVideoLength: fields[5] as int,
      maxGrade: fields[6] as int,
      openDate: fields[7] as DateTime,
      dueDate: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Assignment obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.assignmentId)
      ..writeByte(1)
      ..write(obj.assignmentTitle)
      ..writeByte(2)
      ..write(obj.assignmentDescription)
      ..writeByte(3)
      ..write(obj.minVideos)
      ..writeByte(4)
      ..write(obj.maxVideos)
      ..writeByte(5)
      ..write(obj.maxVideoLength)
      ..writeByte(6)
      ..write(obj.maxGrade)
      ..writeByte(7)
      ..write(obj.openDate)
      ..writeByte(8)
      ..write(obj.dueDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssignmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
