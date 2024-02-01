// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieAdapter extends TypeAdapter<Movie> {
  @override
  final int typeId = 1;

  @override
  Movie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Movie()
      ..id = fields[0] as int
      ..title = fields[1] as String
      ..releaseDate = fields[2] as String
      ..imageURL = fields[3] as String
      ..overview = fields[4] as String
      ..genreIDs = (fields[5] as List).cast<int>();
  }

  @override
  void write(BinaryWriter writer, Movie obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.releaseDate)
      ..writeByte(3)
      ..write(obj.imageURL)
      ..writeByte(4)
      ..write(obj.overview)
      ..writeByte(5)
      ..write(obj.genreIDs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
