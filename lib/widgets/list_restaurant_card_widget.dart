import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trevago_app/configs/api/api.dart';
import 'package:trevago_app/models/restaurant_model.dart';
import 'package:trevago_app/utils/utils.dart';

class ListRestaurantCardWidget extends StatelessWidget {
  const ListRestaurantCardWidget({
    super.key,
    required this.restaurant,
  });

  final RestaurantModel restaurant;

  static final NumberFormat formatter = NumberFormat("##,000");

  String formatPrice(int price) => formatter.format(price).replaceAll(",", ".");

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image(
                    image: NetworkImage("${ApiConfig.restaurant_storage}/${restaurant.image}"),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  height: 86,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        restaurant.title,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyleUtils.mediumDarkGray(18),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.place,
                            color: ColourUtils.darkGray,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            restaurant.location,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyleUtils.regularDarkGray(14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Rp. ${formatPrice(restaurant.price)}",
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyleUtils.semiboldBlue(18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: label == null
            //       ? const SizedBox()
            //       : Container(
            //           padding: const EdgeInsets.symmetric(
            //             horizontal: 8,
            //             vertical: 4,
            //           ),
            //           decoration: const BoxDecoration(
            //             color: ColourUtils.blue,
            //             borderRadius:
            //                 BorderRadius.only(bottomRight: Radius.circular(8)),
            //           ),
            //           child: Text(
            //             label!,
            //             style: TextStyleUtils.regularWhite(12),
            //             softWrap: false,
            //             overflow: TextOverflow.ellipsis,
            //           ),
            //         ),
            // ),
          ],
        ),
      ),
    );
  }
}
