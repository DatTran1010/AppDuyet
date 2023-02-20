class DropDownDatabaseModel {
  DropDownDatabaseModel(
    this.name,
  );
  final dynamic name;

  factory DropDownDatabaseModel.fromJson(json) {
    return DropDownDatabaseModel(
      json['namE_DATA'],
    );
  }

  @override
  String toString() {
    return "$name";
  }

  toJson() {}
}
