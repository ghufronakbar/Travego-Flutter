import 'package:trevago_app/models/tour_package_model.dart';

class TransactionModel {
  const TransactionModel({
    required this.id,
    required this.orderDate,
    this.admin,
    required this.note,
    required this.total,
    required this.tourPackage,
    required this.qty,
    required this.price,
    required this.subtotal,
  });

  final int id;
  final DateTime orderDate;
  final int? admin;
  final String note;
  final int total;
  final TourPackageModel tourPackage;
  final int qty;
  final int price;
  final int subtotal;
}
