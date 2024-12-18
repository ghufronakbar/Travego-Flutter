import 'package:trevago_app/models/transport_model.dart';

class ReservationTransportModel {
  const ReservationTransportModel({
    required this.id,
    required this.orderDate,
    required this.location,
    required this.total,
    required this.transport,
  });

  final int id;
  final DateTime orderDate;
  final String location;
  final int total;
  final TransportModel transport;
}
