// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temrinnot_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TemrinnotModelAdapter extends TypeAdapter<TemrinnotModel> {
  @override
  final int typeId = 5;

  @override
  TemrinnotModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TemrinnotModel(
      id: fields[0] as int,
      temrinId: fields[1] as int,
      ogrenciId: fields[2] as int,
      puan: fields[3] as int,
      notlar: fields[4] as String,
      gelmedi: fields[5] as bool,
      kriterler: fields[6] == null ? [0] : (fields[6] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, TemrinnotModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.temrinId)
      ..writeByte(2)
      ..write(obj.ogrenciId)
      ..writeByte(3)
      ..write(obj.puan)
      ..writeByte(4)
      ..write(obj.notlar)
      ..writeByte(5)
      ..write(obj.gelmedi)
      ..writeByte(6)
      ..write(obj.kriterler);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TemrinnotModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
