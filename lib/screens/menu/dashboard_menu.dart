// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trevago_app/configs/api/api.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/models/users.dart';
import 'package:trevago_app/models/tour_package_model.dart';
import 'package:trevago_app/models/tour_model.dart';
import 'package:trevago_app/models/transport_model.dart';
import 'package:trevago_app/screens/restaurant/restaurants_screen.dart';
import 'package:trevago_app/screens/tours/detail_tour_screen.dart';
import 'package:trevago_app/screens/tours/tours_screen.dart';
import 'package:trevago_app/screens/transports/transports_screen.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/screens/tour_packages/detail_package_screen.dart';
import 'package:intl/intl.dart';
import 'package:trevago_app/screens/transports/detail_transport_screen.dart';
import 'package:trevago_app/screens/tour_packages/packages_screen.dart';
import 'package:trevago_app/widgets/custom_dialog_widget.dart';
import 'package:trevago_app/widgets/tour_card_widget.dart';
import 'package:trevago_app/widgets/tour_transparent_card_widget.dart';

class DashboardMenu extends StatefulWidget {
  const DashboardMenu({super.key});

  @override
  State<DashboardMenu> createState() => _DashboardMenuState();
}

class _DashboardMenuState extends State<DashboardMenu> {
  final NumberFormat formatter = NumberFormat("##,000");
  final List<Map<String, String>> menus = [
    {
      "navigate_to": PackagesScreen.route,
      "title": "Paket Wisata",
      "image": ImageUtils.traveler,
    },
    {
      "navigate_to": ToursScreen.route,
      "title": "Wisata",
      "image": ImageUtils.destination,
    },
    {
      "navigate_to": TransportsScreen.route,
      "title": "Transportasi",
      "image": ImageUtils.transport,
    },
    {
      "navigate_to": RestaurantsScreen.route,
      "title": "Kuliner",
      "image": ImageUtils.restaurant,
    },
  ];
  final List tourCategories = [
    {
      "image":
          "https://www.cimbniaga.co.id/content/dam/cimb/inspirasi/masjid-agung.webp",
      "name": "Religi",
    },
    {
      "image":
          "https://s1-id.alongwalker.co/wp-content/uploads/2024/08/image-top-18-lokasi-wisata-sejarah-bandung-yang-keren-dan-edukasional-7ffbe310cf45a0754c2da7e93c2007fb.jpeg",
      "name": "Sejarah",
    },
    {
      "image":
          "https://www.agentwisatabromo.com/wp-content/uploads/2019/08/Paket-Wisata-Tumpak-Sewu-2-Hari-1-Malam.jpg",
      "name": "Alam",
    },
  ];

  String formatPrice(int price) => formatter.format(price).replaceAll(",", ".");

  Future<Users?> retrieveUserProfile(BuildContext context) async {
    try {
      final Users profile = await getProfile();
      return profile;
    } catch (error) {
      CustomDialogWidget.showErrorDialog(context, error.toString());
      return null;
    }
  }

  Future<List<TourPackageModel>> retrieveTourPackages() async {
    try {
      final List packages = await getTourPackages();
      final List<TourPackageModel> listPackage = [];
      for (var element in packages) {
        listPackage.add(TourPackageModel(
          id: element["id_paket"],
          title: element["nama_paket"],
          description: element["deskripsi"],
          price: element["harga"],
          tour: TourModel(
            id: element["id_wisata"],
            title: element["nama_wisata"],
            location: element["lokasi"],
            price: element["harga_tiket"],
            description: element["deskripsi_wisata"],
            image: element["gambar_wisata"],
          ),
        ));
      }
      return Future.value(listPackage);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<List<TransportModel>> retrieveTransports() async {
    try {
      final List transports = await getTransports();
      final List<TransportModel> listTransport = [];
      for (var element in transports) {
        listTransport.add(
          TransportModel(
            id: element["id_kendaraan"],
            type: element["tipe_kendaraan"],
            transportNumber: element["no_kendaraan"],
            seatCount: element["jumlah_seat"],
            price: element["harga_sewa"],
            name: element["nama_kendaraan"],
            image: element["gambar_kendaraan"],
          ),
        );
      }
      return Future.value(listTransport);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<List<TourModel>> retrieveTours() async {
    try {
      final List tours = await getTours();
      final List<TourModel> listTour = [];
      for (var element in tours) {
        listTour.add(
          TourModel(
            id: element["id_wisata"],
            title: element["nama_wisata"],
            location: element["lokasi"],
            price: element["harga_tiket"],
            description: element["deskripsi_wisata"],
            image: element["gambar_wisata"],
          ),
        );
      }
      return Future.value(listTour);
    } catch (error) {
      return Future.error(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 56),
          children: [
            // *Greeting
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const Image(
                      image: AssetImage(ImageUtils.logooo),
                      width: 42,
                      height: 42,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FutureBuilder(
                      future: retrieveUserProfile(context),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            "Selamat Datang ${snapshot.data!.name.split(" ")[0]}",
                            overflow: TextOverflow.clip,
                            style: TextStyleUtils.semiboldBlack(20),
                          );
                        }
                        return const Text("");
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hari ini kamu mau",
                    style: TextStyleUtils.boldDarkGray(24),
                  ),
                  Row(
                    children: [
                      Text(
                        "pergi ",
                        style: TextStyleUtils.boldBlue(24),
                      ),
                      Text(
                        "ke mana?",
                        style: TextStyleUtils.boldDarkGray(24),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            // *Menu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: menus.map(
                  (menu) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(menu["navigate_to"]!);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: ColourUtils.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Image(image: AssetImage(menu["image"]!)),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            menu["title"]!,
                            style: TextStyleUtils.semiboldBlack(14),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            const SizedBox(height: 24),
            // *Tour Destination
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Text(
            //     "Destinasi Wisata",
            //     style: TextStyleUtils.semiboldDarkGray(18),
            //   ),
            // ),
            // const SizedBox(height: 4),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: GridView(
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 3,
            //       crossAxisSpacing: 8,
            //       childAspectRatio: 9 / 10,
            //     ),
            //     shrinkWrap: true,
            //     children: tourCategories
            //         .map(
            //           (val) => Container(
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(8),
            //               color: Colors.white,
            //               boxShadow: [
            //                 BoxShadow(
            //                   blurRadius: 4,
            //                   color: Colors.black.withOpacity(.25),
            //                   offset: const Offset(1, 1),
            //                 ),
            //               ],
            //             ),
            //             alignment: Alignment.bottomCenter,
            //             child: Column(
            //               children: [
            //                 Expanded(
            //                   child: ClipRRect(
            //                     borderRadius: const BorderRadius.vertical(
            //                         top: Radius.circular(8)),
            //                     child: Image(
            //                       image: NetworkImage(val["image"]),
            //                       fit: BoxFit.cover,
            //                     ),
            //                   ),
            //                 ),
            //                 Container(
            //                   padding:
            //                       const EdgeInsets.symmetric(horizontal: 8),
            //                   alignment: Alignment.center,
            //                   decoration: const BoxDecoration(
            //                     color: Colors.white,
            //                     borderRadius: BorderRadius.vertical(
            //                         bottom: Radius.circular(8)),
            //                   ),
            //                   height: 32,
            //                   child: Text(
            //                     val["name"],
            //                     style: TextStyleUtils.semiboldDarkGray(16),
            //                     overflow: TextOverflow.fade,
            //                     softWrap: false,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         )
            //         .toList(),
            //   ),
            // ),
            // const SizedBox(height: 14),
            Container(
              height: 4,
              color: ColourUtils.extraLightGray,
            ),
            const SizedBox(height: 14),
            // *Popular Tours
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Paket Wisata Populer",
                    style: TextStyle(
                      color: ColourUtils.darkGray,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(PackagesScreen.route);
                    },
                    icon: const Icon(
                      Icons.chevron_right,
                      color: ColourUtils.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: FutureBuilder<List<TourPackageModel>>(
                future: retrieveTourPackages(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          snapshot.error.toString(),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: TextStyleUtils.regularDarkGray(14),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          DetailPackageScreen.route,
                          arguments: snapshot.data!.elementAt(index),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 148,
                        child: TourTransparentCardWidget(
                          imageUrl:
                              '${ApiConfig.tour_package_storage}/${snapshot.data!.elementAt(index).tour.image}',
                          title: snapshot.data!.elementAt(index).title,
                          location:
                              snapshot.data!.elementAt(index).tour.location,
                          price:
                              "Rp. ${formatPrice(snapshot.data!.elementAt(index).price)}",
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 14),
            Container(
              height: 4,
              color: ColourUtils.extraLightGray,
            ),
            const SizedBox(height: 14),
            // *Recommended Tours
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Destinasi Wisata Populer",
                    style: TextStyleUtils.semiboldDarkGray(18),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(ToursScreen.route);
                    },
                    icon: const Icon(
                      Icons.chevron_right,
                      color: ColourUtils.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 196,
              child: FutureBuilder<List<TourModel>>(
                future: retrieveTours(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          snapshot.error.toString(),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: TextStyleUtils.regularDarkGray(14),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          DetailTourScreen.route,
                          arguments: snapshot.data!.elementAt(index),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 180,
                        child: TourCardWidget(
                          imageUrl:
                              '${ApiConfig.tour_package_storage}/${snapshot.data!.elementAt(index).image}',
                          title: snapshot.data!.elementAt(index).title,
                          location: snapshot.data!.elementAt(index).location,
                          price:
                              "Rp. ${formatPrice(snapshot.data!.elementAt(index).price)}",
                          label: "Rekomendasi",
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // *Transport
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Transport",
                    style: TextStyleUtils.semiboldDarkGray(18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(TransportsScreen.route);
                    },
                    child: const Icon(
                      Icons.chevron_right,
                      color: ColourUtils.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            FutureBuilder<List<TransportModel>>(
              future: retrieveTransports(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        snapshot.error.toString(),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyleUtils.regularDarkGray(14),
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        DetailTransportScreen.route,
                        arguments: snapshot.data!.elementAt(index),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      height: 84,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            blurRadius: 4,
                            offset: const Offset(.5, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image(
                              image: NetworkImage(
                                  '${ApiConfig.transport_storage}/${snapshot.data!.elementAt(index).image}'),
                              height: 84,
                              width: 84,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  snapshot.data!.elementAt(index).name,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Rp. ${formatPrice(snapshot.data!.elementAt(index).price)}",
                                      style: const TextStyle(
                                        color: ColourUtils.purple,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Text(
                                      " / hari",
                                      style: TextStyle(
                                        color: ColourUtils.gray,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
