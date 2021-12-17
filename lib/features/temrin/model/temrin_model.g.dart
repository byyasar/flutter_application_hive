// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temrin_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TemrinModelAdapter extends TypeAdapter<TemrinModel> {
  @override
  final int typeId = 4;

  @override
  TemrinModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TemrinModel(
      id: fields[0] as int,
      temrinKonusu: fields[1] as String,
      dersId: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TemrinModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.temrinKonusu)
      ..writeByte(2)
      ..write(obj.dersId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TemrinModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
