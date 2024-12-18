// ignore_for_file: non_constant_identifier_names

class RestaurantModel {
  const RestaurantModel(
      {required this.id,
      required this.title,
      required this.menu,
      required this.location,
      required this.phone,
      required this.price,
      required this.total_pax,
      required this.image,
      required this.description});

  final int id;
  final String title;
  final String menu;
  final String location;
  final String phone;
  final int price;
  final int total_pax;
  final String image;
  final String description;
}
