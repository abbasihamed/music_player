// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayListAdapter extends TypeAdapter<PlayList> {
  @override
  final int typeId = 0;

  @override
  PlayList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayList(
      listName: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlayList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.listName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
