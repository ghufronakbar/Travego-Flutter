import 'package:trevago_app/models/tour_model.dart';

class TourPackageModel {
  const TourPackageModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.tour,
  });

  final int id;
  final String title;
  final String description;
  final int price;
  final TourModel tour;
}
