enum OrderType {
  asc,
  desc,
}

class OrderByModel {
  String? name;
  OrderType? type;
  
  OrderByModel({
    this.name,
    this.type = OrderType.asc,
  });
}
