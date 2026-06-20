// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityModelHiveAdapter extends TypeAdapter<ActivityModelHive> {
  @override
  final int typeId = 1;

  @override
  ActivityModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivityModelHive()
      ..cost = fields[0] as int
      ..time = fields[1] as String
      ..landmarkName = fields[2] as String
      ..description = fields[3] as String
      ..image = fields[4] as String
      ..lat = fields[5] as double
      ..lng = fields[6] as double;
  }

  @override
  void write(BinaryWriter writer, ActivityModelHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.cost)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.landmarkName)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.lat)
      ..writeByte(6)
      ..write(obj.lng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
