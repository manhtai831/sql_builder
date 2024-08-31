import '../column_enum.dart';

class ColumnModel {
  String? name;
  ColumnType? type;
  bool? primary;
  bool? increment;

  ColumnModel({
    this.name,
    this.type,
    this.primary,
    this.increment,
  });
}
