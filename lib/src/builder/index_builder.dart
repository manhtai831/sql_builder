
import '../model/column_model.dart';
import '../model/query_model.dart';

class IndexBuilder {
  final TableQueryModel _table = TableQueryModel();
  final List<ColumnModel> _onCols = [];
  String _indexName = '';

  IndexBuilder setTable(String name) {
    _table.tableName = name;
    return this;
  }

  IndexBuilder setIndexName(String name) {
    _indexName = name;
    return this;
  }

  IndexBuilder atColumn(ColumnModel col) {
    _onCols.add(col);
    return this;
  }

  String build() {
    assert(_table.tableName != null);
    assert(_onCols.every((e) => e.name != null));

    final sb = StringBuffer();
    Iterable<String> nameCols = _onCols.map((e) => e.name ?? '');
    _getIndexName();
    sb
      ..write('CREATE INDEX')
      ..write(' ')
      ..write(_indexName)
      ..write(' ')
      ..write('ON')
      ..write(' ')
      ..write(_table.tableName)
      ..write('(')
      ..write(nameCols.join(', '))
      ..write(')');
    return sb.toString();
  }

  String _getIndexName() {
    Iterable<String> nameCols = _onCols.map((e) => e.name ?? '');
    if (_indexName.isEmpty) {
      _indexName = 'idx_${nameCols.join('_')}';
    }
    return _indexName;
  }

  String drop() {
    final sb = StringBuffer()
      ..write('DROP INDEX')
      ..write(' ')
      ..write(_getIndexName());
      
    return sb.toString();
  }
}
