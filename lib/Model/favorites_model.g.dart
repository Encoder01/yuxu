// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoritesModelAdapter extends TypeAdapter<FavoritesModel> {
  @override
  final int typeId = 0;

  @override
  FavoritesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoritesModel(
      volume: fields[1] as double,
      icon1: fields[3] as String,
      sesPath: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoritesModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(3)
      ..write(obj.icon1)
      ..writeByte(2)
      ..write(obj.sesPath)
      ..writeByte(1)
      ..write(obj.volume);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
