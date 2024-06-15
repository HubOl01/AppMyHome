class ExpenseModel {
  final int id;
  final String name;
  final List<ServiceModel> list;
  double sumCost;
  final String status;
  final DateTime dateTime;
  ExpenseModel(
      {required this.id,
      required this.name,
      required this.list,
      required this.sumCost,
      required this.status,
      required this.dateTime});
}

class ServiceModel {
  final int id;
  final String name;
  final double rate;
  final String unit;
  final double size;
  double price;

  ServiceModel(
      {required this.id,
      required this.name,
      required this.rate,
      required this.unit,
      required this.size,
      required this.price});
}
