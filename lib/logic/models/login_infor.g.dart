// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_infor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginInforAdapter extends TypeAdapter<LoginInfor> {
  @override
  final int typeId = 0;

  @override
  LoginInfor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginInfor(
      fields[0] as String,
      fields[1] as String,
      fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LoginInfor obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.isSaved);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginInforAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
