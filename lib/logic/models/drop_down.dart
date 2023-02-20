class DropdownModel {
  DropdownModel(this.id, this.name,);
  final dynamic id;
  final dynamic name;


  factory DropdownModel.fromJson(json) {
    return DropdownModel(
      json['iD_DTL'],
      json['teN_TAI_LIEU'],
    );
  }

  @override
  String toString() {
    return """
DropdownModel:
- id: $id,
- name: $name,
""";
  }
}