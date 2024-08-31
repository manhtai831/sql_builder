import '../model/page_model.dart';
import '../model/query_model.dart';
import '../model/select_model.dart';
import '../model/where_model.dart';

class QueryBuilder {
  final QueryModel _query = QueryModel();

  QueryBuilder createBuilder({TableQueryModel? table, PageModel? paging}) {
    _query
      ..mainTable = table
      ..paging = paging;
    return this;
  }

  QueryBuilder join({required TableJoinModel join}) {
    _query.joinTables ??= [];
    _query.joinTables?.add(join);
    return this;
  }

  QueryBuilder select({
    Iterable<String>? selects,
    Iterable<SelectModel>? cols,
    bool distinct = false,
  }) {
    _query.selects ??= [];
    if (selects != null) {
      _query.selects?.addAll(selects);
    }
    if (cols != null) {
      for (var it in cols) {
        assert(it.name != null);
        final buffer = StringBuffer();
        buffer.write(it.name);
        if (it.alias != null && it.alias!.isNotEmpty) {
          buffer
            ..write(' ')
            ..write('AS')
            ..write(' ')
            ..write(it.alias);
        }
        _query.selects?.add(buffer.toString());
      }
    }

    _query.distinct = distinct;
    return this;
  }

  QueryBuilder where({WhereModel? condition}) {
    _query.where = condition;
    return this;
  }

  String build() {
    final buffer = StringBuffer();
    buffer
      ..write('SELECT')
      ..write(' ');
    if (_query.distinct == true) {
      buffer
        ..write('DISTINCT')
        ..write(' ');
    }
    if (_query.selects != null && _query.selects!.isNotEmpty) {
      buffer.writeAll(_query.selects!, ', ');
    } else {
      buffer.write('*');
    }
    if (_query.mainTable?.tableName != null) {
      buffer
        ..write(' ')
        ..write('FROM')
        ..write(' ')
        ..write(_query.mainTable?.tableName);
    }

    if (_query.mainTable?.alias != null) {
      buffer
        ..write(' ')
        ..write('AS')
        ..write(' ')
        ..write(_query.mainTable?.alias);
    }

    if (_query.joinTables != null && _query.joinTables!.isNotEmpty) {
      buffer
        ..write(' ')
        ..writeAll(
          _query.joinTables!.map((e) =>
              'JOIN ${e.tableName}${e.alias != null ? ' AS ${e.alias}' : ''} ON ${e.on}'),
          ' ',
        );
    }
    if (_query.where?.where != null) {
      buffer
        ..write(' ')
        ..write('WHERE')
        ..write(' ')
        ..write(_query.where?.where);
    }
    if (_query.where?.groupBy != null) {
      buffer
        ..write(' ')
        ..write('GROUP BY')
        ..write(' ')
        ..write(_query.where?.groupBy);
    }
    if (_query.where?.having != null) {
      buffer
        ..write(' ')
        ..write('HAVING')
        ..write(' ')
        ..write(_query.where?.having);
    }
    if (_query.where?.orderBy != null) {
      assert(_query.where?.orderBy?.name != null);
      assert(_query.where?.orderBy?.type != null);
      buffer
        ..write(' ')
        ..write('ORDER BY')
        ..write(' ')
        ..write(_query.where?.orderBy?.name)
        ..write(' ')
        ..write(_query.where?.orderBy?.type?.name.toUpperCase());
    }
    if (_query.paging?.limit != null) {
      buffer
        ..write(' ')
        ..write('LIMIT')
        ..write(' ')
        ..write(_query.paging?.limit);
    }
    if (_query.paging?.offset != null) {
      buffer
        ..write(' ')
        ..write('OFFSET')
        ..write(' ')
        ..write(_query.paging?.offset);
    }

    return buffer.toString();
  }
}
