// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decision_map.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DecisionMapAdapter extends TypeAdapter<DecisionMap> {
  @override
  final int typeId = 0;

  @override
  DecisionMap read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DecisionMap()
      ..currentID = fields[0] as int
      ..option1ID = fields[1] as int
      ..option2ID = fields[2] as int
      ..description = fields[3] as String
      ..option1Text = fields[4] as String
      ..option2Text = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, DecisionMap obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.currentID)
      ..writeByte(1)
      ..write(obj.option1ID)
      ..writeByte(2)
      ..write(obj.option2ID)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.option1Text)
      ..writeByte(5)
      ..write(obj.option2Text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DecisionMapAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
