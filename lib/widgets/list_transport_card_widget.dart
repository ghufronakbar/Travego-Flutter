import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trevago_app/configs/api/api.dart';
import 'package:trevago_app/models/transport_model.dart';
import 'package:trevago_app/utils/utils.dart';

class ListTransportCardWidget extends StatelessWidget {
  const ListTransportCardWidget({
    super.key,
    required this.transport,
    this.height,
  });

  static final NumberFormat formatter = NumberFormat("##,000");
  final TransportModel transport;
  final double? height;

  String formatPrice(int price) => formatter.format(price).replaceAll(",", ".");

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 148,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.25),
            blurRadius: 4,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Image(
            image: NetworkImage(
                '${ApiConfig.transport_storage}/${transport.image}'),
            width: 120,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 32),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  transport.name,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyleUtils.semiboldDarkGray(20),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.airline_seat_recline_extra_sharp,
                      color: ColourUtils.gray,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      transport.seatCount.toString(),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyleUtils.mediumBlue(16),
                    ),
                  ],
                ),
                Text(
                  "Rp. ${formatPrice(transport.price)} /hari",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  softWrap: false,
                  style: TextStyleUtils.semiboldRedCherry(16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
