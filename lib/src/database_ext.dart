import 'builder/query_builder.dart';
import 'model/query_model.dart';
import 'model/where_model.dart';

String getAllTableQuery() {
  return QueryBuilder()
      .createBuilder(table: TableQueryModel(tableName: 'sqlite_master'))
      .where(
        condition: WhereModel(where: 'type = table'),
      )
      .build();
}

String getCountQuery({String? tableName}) {
  return QueryBuilder()
      .createBuilder(table: TableQueryModel(tableName: tableName))
      .select(selects: ['COUNT(*)']).build();
}

String getSqlVersionQuery({String? tableName}) {
  return QueryBuilder().select(selects: ['sqlite_version()']).build();
}

String getAllIndexQuery(String tableName) {
  return 'PRAGMA index_list(\'$tableName\')';
}
