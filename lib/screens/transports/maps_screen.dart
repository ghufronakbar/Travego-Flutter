import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trevago_app/utils/utils.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  static const String route = "/maps";

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng currentCoordinate = const LatLng(-7.8031634, 110.3335592);
  late GoogleMapController mapController;
  Set<Marker> marker = <Marker>{};
  // late List<Placemark> placeMark;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _onLocationSelect(LatLng coordinate) async {
    // List<Placemark> placeMark = await placemarkFromCoordinates(
    //   coordinate.latitude,
    //   coordinate.longitude,
    // );
    setState(() {
      currentCoordinate = coordinate;
      marker = <Marker>{
        Marker(
          markerId: const MarkerId("1"),
          position: currentCoordinate,
          infoWindow: InfoWindow(
              title: "${coordinate.latitude},${coordinate.longitude}"),
        ),
      };
      // currentCoordinate = coordinate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: currentCoordinate,
              zoom: 11,
            ),
            compassEnabled: true,
            onMapCreated: _onMapCreated,
            mapToolbarEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onTap: _onLocationSelect,
            markers: marker,
          ),
          Positioned(
            top: 16,
            left: 16,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              icon: const Icon(
                Icons.chevron_left,
                color: ColourUtils.blue,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: marker.isNotEmpty
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(currentCoordinate);
                    },
                    style: ButtonStyleUtils.activeButton,
                    child: Text(
                      "Pilih Lokasi",
                      style: TextStyleUtils.mediumWhite(16),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
