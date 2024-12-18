class TourModel {
  const TourModel({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.description,
    required this.image,
  });

  final int id;
  final String title;
  final String location;
  final int price;
  final String description;
  final String image;
}
