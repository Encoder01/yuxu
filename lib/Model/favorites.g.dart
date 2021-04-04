// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoritesAdapter extends TypeAdapter<Favorites> {
  @override
  final int typeId = 1;

  @override
  Favorites read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favorites(
      favorites: (fields[0] as List)?.cast<FavoritesModel>(),
      ID: fields[1] as String,
      Name: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Favorites obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.favorites)
      ..writeByte(1)
      ..write(obj.ID)
      ..writeByte(2)
      ..write(obj.Name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
