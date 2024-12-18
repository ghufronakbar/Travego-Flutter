class TransportModel {
  const TransportModel({
    required this.id,
    required this.type,
    required this.transportNumber,
    required this.seatCount,
    required this.price,
    required this.name,
    required this.image,
  });

  final int id;
  final String type;
  final String transportNumber;
  final int seatCount;
  final int price;
  final String name;
  final String image;
}
