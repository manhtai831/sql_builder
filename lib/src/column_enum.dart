enum ColumnType {
  /// int
  integer,

  dateTime,

  /// double
  real,

  /// String
  text,
  // Uint8List
  blob,
}

extension ColumnTypeExt on ColumnType {
  String stringtify() {
    switch (this) {
      case ColumnType.integer:
      case ColumnType.dateTime:
        return 'INTEGER';
      case ColumnType.text:
        return 'TEXT';
      case ColumnType.real:
        return 'REAL';
      case ColumnType.blob:
        return 'BLOB';
      default:
        return '';
    }
  }
}

String toWhereValue(dynamic field) {
  switch (field.runtimeType) {
    case const (String):
    case const (bool):
      return '\'${field.toString()}\'';
    case const (num):
    case const (double):
    case const (int):
      return '$field';
  }
  return '';
}
