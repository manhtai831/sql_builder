import '../column_enum.dart';
import '../model/column_model.dart';
import '../model/query_model.dart';

class TableBuilder {
  final TableQueryModel _table = TableQueryModel();
  final List<ColumnModel> _cols = [];

  TableBuilder setTable({String? name}) {
    _table.tableName = name;
    return this;
  }

  TableBuilder setColumn(ColumnModel col) {
    _cols.add(col);
    return this;
  }

  void _validate() {
    assert(_table.tableName != null);
  }

  String build() {
    _validate();
    final sb = StringBuffer();
    sb
      ..write('CREATE TABLE IF NOT EXISTS')
      ..write(' ')
      ..write(_table.tableName)
      ..write('(');

    final buffers = _cols.map((e) {
      final buffer = StringBuffer();
      buffer
        ..write(e.name)
        ..write(' ')
        ..write(e.type?.stringtify());
      if (e.primary == true) {
        buffer
          ..write(' ')
          ..write('PRIMARY KEY');
      }
      if (e.increment == true && e.type == ColumnType.integer) {
        buffer
          ..write(' ')
          ..write('AUTOINCREMENT');
      }
      return buffer;
    });

    sb
      ..write(buffers.map((e) => e.toString()).join(', '))
      ..write(')');
    return sb.toString();
  }

  String drop() {
    _validate();
    StringBuffer sb = StringBuffer();
    sb
      ..write('DROP TABLE IF EXISTS')
      ..write(' ')
      ..write(_table.tableName);
    return sb.toString();
  }
}
