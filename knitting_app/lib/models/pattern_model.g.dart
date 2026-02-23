// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pattern_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PatternModelAdapter extends TypeAdapter<PatternModel> {
  @override
  final int typeId = 0;

  @override
  PatternModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PatternModel(
      id: fields[0] as int,
      title: fields[1] as String,
      difficulty: fields[2] as String,
      estimatedHour: fields[3] as String,
      colors: (fields[4] as List).cast<String>(),
      yarnType: fields[5] as String,
      hookSize: fields[6] as String,
      imageUrl: fields[7] as String,
      videoUrl: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PatternModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.difficulty)
      ..writeByte(3)
      ..write(obj.estimatedHour)
      ..writeByte(4)
      ..write(obj.colors)
      ..writeByte(5)
      ..write(obj.yarnType)
      ..writeByte(6)
      ..write(obj.hookSize)
      ..writeByte(7)
      ..write(obj.imageUrl)
      ..writeByte(8)
      ..write(obj.videoUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatternModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
