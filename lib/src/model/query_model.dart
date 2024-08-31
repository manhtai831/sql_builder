
import 'page_model.dart';
import 'where_model.dart';

class QueryModel {
  TableQueryModel? mainTable;
  List<TableJoinModel>? joinTables = [];
  PageModel? paging;
  List<String>? selects = [];
  WhereModel? where;
  bool? distinct;

  QueryModel({
    this.mainTable,
    this.joinTables,
    this.paging,
    this.selects,
    this.where,
    this.distinct,
  });
}

class TableQueryModel {
  String? tableName;
  String? alias;

  TableQueryModel({
    this.tableName,
    this.alias,
  });
}

class TableJoinModel extends TableQueryModel {
  String? on;
  TableJoinModel({
    super.tableName,
    super.alias,
    this.on,
  }) {
    assert(on != null);
    assert(tableName != null);
  }
}
