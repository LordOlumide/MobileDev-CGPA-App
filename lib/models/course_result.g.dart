// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseResultAdapter extends TypeAdapter<CourseResult> {
  @override
  final int typeId = 0;

  @override
  CourseResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseResult(
      uniqueId: fields[0] as String?,
      courseTitle: fields[1] as String,
      courseDescription: fields[2] as String,
      marks: fields[3] as int,
      units: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CourseResult obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.uniqueId)
      ..writeByte(1)
      ..write(obj.courseTitle)
      ..writeByte(2)
      ..write(obj.courseDescription)
      ..writeByte(3)
      ..write(obj.marks)
      ..writeByte(4)
      ..write(obj.units);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
