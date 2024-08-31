import 'order_by_model.dart';

class WhereModel {
  String? where;
  String? groupBy;
  OrderByModel? orderBy;
  String? having;

  WhereModel({
    this.where,
    this.groupBy,
    this.orderBy,
    this.having,
  });
  
}
