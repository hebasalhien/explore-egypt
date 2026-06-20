// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripModelHiveAdapter extends TypeAdapter<TripModelHive> {
  @override
  final int typeId = 3;

  @override
  TripModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TripModelHive()
      ..remoteId = fields[0] as String?
      ..days = fields[1] as int
      ..title = fields[2] as String
      ..active = fields[3] as bool
      ..dayModels = (fields[4] as List).cast<DayModelHive>();
  }

  @override
  void write(BinaryWriter writer, TripModelHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.remoteId)
      ..writeByte(1)
      ..write(obj.days)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.active)
      ..writeByte(4)
      ..write(obj.dayModels);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
