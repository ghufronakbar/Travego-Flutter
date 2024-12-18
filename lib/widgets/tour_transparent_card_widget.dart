import 'package:flutter/material.dart';
import 'package:trevago_app/utils/utils.dart';

class TourTransparentCardWidget extends StatelessWidget {
  const TourTransparentCardWidget({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.location,
    required this.price,
  });

  final String imageUrl;
  final String title;
  final String location;
  final String price;

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
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image(
                image: NetworkImage(
                  imageUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: const BoxDecoration(
                  color: ColourUtils.blue,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                ),
                child: Text(
                  price,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyleUtils.mediumWhite(16),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.5),
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyleUtils.regularWhite(16),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      location,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyleUtils.regularWhite(14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}