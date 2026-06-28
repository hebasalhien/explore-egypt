// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayModelHiveAdapter extends TypeAdapter<DayModelHive> {
  @override
  final int typeId = 2;

  @override
  DayModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayModelHive()
      ..totalCost = fields[0] as int?
      ..activities = (fields[1] as List?)?.cast<ActivityModelHive>();
  }

  @override
  void write(BinaryWriter writer, DayModelHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.totalCost)
      ..writeByte(1)
      ..write(obj.activities);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
