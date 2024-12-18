import 'package:trevago_app/models/restaurant_model.dart';

class ReservationRestaurantModel {
  const ReservationRestaurantModel({
    required this.id,
    required this.orderDate,
    required this.totalPax,
    required this.restaurant,
  });

  final int id;
  final DateTime orderDate;
  final int totalPax;
  final RestaurantModel restaurant;
}
