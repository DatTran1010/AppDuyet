class DropDownNUQModel {
  DropDownNUQModel(
    this.id,
    this.name,
  );
  final dynamic id;
  final dynamic name;

  factory DropDownNUQModel.fromJson(json) {
    return DropDownNUQModel(
      json['iD_NUQ'],
      json['teN_NUQ'],
    );
  }

  @override
  String toString() {
    return """
DropDownNUQModel:
- id: $id,
- name: $name,
""";
  }
}
