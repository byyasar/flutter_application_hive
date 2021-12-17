// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sinif_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SinifModelAdapter extends TypeAdapter<SinifModel> {
  @override
  final int typeId = 3;

  @override
  SinifModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SinifModel(
      id: fields[0] as int,
      sinifAd: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SinifModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.sinifAd);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SinifModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
