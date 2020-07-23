// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planner.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlannerAdapter extends TypeAdapter<Planner> {
  @override
  final typeId = 0;

  @override
  Planner read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Planner()
      ..name = fields[0] as String
      ..bookChapters = (fields[1] as Map)?.map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List)?.cast<int>()));
  }

  @override
  void write(BinaryWriter writer, Planner obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.bookChapters);
  }
}
