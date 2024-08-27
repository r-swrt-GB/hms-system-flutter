// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubmissionAdapter extends TypeAdapter<Submission> {
  @override
  final int typeId = 1;

  @override
  Submission read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Submission(
      submissionId: fields[0] as int,
      submissionDate: fields[1] as DateTime,
      assignmentId: fields[2] as int,
      submissionGrade: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Submission obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.submissionId)
      ..writeByte(1)
      ..write(obj.submissionDate)
      ..writeByte(2)
      ..write(obj.assignmentId)
      ..writeByte(3)
      ..write(obj.submissionGrade);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubmissionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
