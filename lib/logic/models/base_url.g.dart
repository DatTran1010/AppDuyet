// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_url.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BaseUrlAdapter extends TypeAdapter<BaseUrl> {
  @override
  final int typeId = 1;

  @override
  BaseUrl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BaseUrl(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BaseUrl obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.domain);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseUrlAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
