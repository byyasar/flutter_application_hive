// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ogrenci_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OgrenciModelAdapter extends TypeAdapter<OgrenciModel> {
  @override
  final int typeId = 1;

  @override
  OgrenciModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OgrenciModel(
      id: fields[0] as int,
      name: fields[1] as String,
      nu: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, OgrenciModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.nu);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OgrenciModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
