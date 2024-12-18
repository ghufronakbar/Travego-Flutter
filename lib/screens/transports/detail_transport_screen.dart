// ignore_for_file: unused_element

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trevago_app/models/transport_model.dart';
import 'package:trevago_app/screens/transports/maps_screen.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/screens/transports/order_transport_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailTransportScreen extends StatefulWidget {
  const DetailTransportScreen({super.key});

  static const String route = "/detail_transport";

  @override
  State<DetailTransportScreen> createState() => _DetailTransportScreenState();
}

class _DetailTransportScreenState extends State<DetailTransportScreen> {
  static final NumberFormat formatter = NumberFormat("##,000");
  late TransportModel transport;
  late TextEditingController bookingDateController;
  late TextEditingController bookingTimeController;
  late TextEditingController bookingLocationController;
  DateTime bookingDate = DateTime.now();
  DateTime bookingTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    bookingDateController = TextEditingController(
        text: DateFormat("dd MMMM yyyy").format(bookingDate));
    bookingTimeController =
        TextEditingController(text: DateFormat("HH:mm").format(bookingDate));
    bookingLocationController = TextEditingController();
  }

  String formatPrice(int price) => formatter.format(price).replaceAll(",", ".");

  Future<void> _showTimePicker() async {
    TimeOfDay? selectedTime;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Pilih Waktu Penjemputan",
          style: TextStyleUtils.mediumDarkGray(20),
        ),
        content: SizedBox(
          height: 200,
          child: CupertinoApp(
            debugShowCheckedModeBanner: false,
            color: Colors.white,
            theme: CupertinoThemeData(
              barBackgroundColor: Colors.white,
              brightness: Brightness.light,
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: TextStyleUtils.mediumBlue(16),
              ),
            ),
            builder: (context, child) => CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              use24hFormat: true,
              initialDateTime: bookingTime,
              onDateTimeChanged: (time) {
                selectedTime = TimeOfDay(hour: time.hour, minute: time.minute);
              },
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Batal",
              style: TextStyleUtils.mediumBlue(16),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedTime != null) {
                setState(() {
                  bookingTime = DateTime(
                    bookingTime.year,
                    bookingTime.month,
                    bookingTime.day,
                    selectedTime!.hour,
                    selectedTime!.minute,
                  );
                  bookingTimeController.text =
                      DateFormat("HH:mm").format(bookingTime);
                });
              }
              Navigator.of(context).pop();
            },
            style: ButtonStyleUtils.activeButton,
            child: Text(
              "Selesai",
              style: TextStyleUtils.mediumWhite(16),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDatePicker() async {
    DateTime? selectedDate;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Pilih Tanggal Penjemputan",
          style: TextStyleUtils.mediumDarkGray(20),
        ),
        content: SizedBox(
          height: 200,
          child: CupertinoApp(
            debugShowCheckedModeBanner: false,
            color: Colors.white,
            theme: CupertinoThemeData(
              barBackgroundColor: Colors.white,
              brightness: Brightness.light,
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: TextStyleUtils.mediumBlue(16),
              ),
            ),
            builder: (context, child) => CupertinoDatePicker(
              dateOrder: DatePickerDateOrder.dmy,
              mode: CupertinoDatePickerMode.date,
              minimumDate: bookingDate,
              initialDateTime: bookingDate,
              onDateTimeChanged: (date) {
                selectedDate = DateTime(date.year, date.month, date.day);
              },
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Batal",
              style: TextStyleUtils.mediumBlue(16),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedDate != null) {
                setState(() {
                  bookingDate = DateTime(
                    selectedDate!.year,
                    selectedDate!.month,
                    selectedDate!.day,
                    bookingDate.hour,
                    bookingDate.minute,
                  );
                  bookingDateController.text =
                      DateFormat("dd MMMM yyyy").format(bookingDate);
                });
              }
              Navigator.of(context).pop();
            },
            style: ButtonStyleUtils.activeButton,
            child: Text(
              "Selesai",
              style: TextStyleUtils.mediumWhite(16),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showMap() async {
    LatLng? currentCoordinate =
        await Navigator.of(context).pushNamed(MapsScreen.route) as LatLng?;
    setState(() {
      bookingLocationController.text =
          "${currentCoordinate!.latitude},${currentCoordinate.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    transport = ModalRoute.of(context)!.settings.arguments as TransportModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColourUtils.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Pemesanan Transportasi",
          style: TextStyleUtils.mediumWhite(20),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  color: Colors.black.withOpacity(.25),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // * Location
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: ColourUtils.lightGray,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: ColourUtils.darkGray,
                        size: 32,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Lokasi Rental Anda",
                              style: TextStyleUtils.regularDarkGray(16),
                            ),
                            TextField(
                              controller: bookingLocationController,
                              readOnly: true,
                              style: TextStyleUtils.boldDarkGray(16),
                              onTap: () {
                                showMap();
                              },
                              decoration: InputDecorationUtils.noBorder(
                                "Tentukan Lokasi Penjemputan",
                                contentPadding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // * Date
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: ColourUtils.lightGray,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: ColourUtils.darkGray,
                        size: 32,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tanggal Penjemputan",
                              style: TextStyleUtils.regularDarkGray(16),
                            ),
                            TextField(
                              controller: bookingDateController,
                              readOnly: true,
                              style: TextStyleUtils.boldDarkGray(16),
                              onTap: () {
                                _showDatePicker();
                              },
                              decoration: InputDecorationUtils.noBorder(
                                "Tentukan Tanggal Penjemputan",
                                contentPadding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // * Time
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: ColourUtils.lightGray,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: ColourUtils.darkGray,
                        size: 32,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Waktu Penjemputan",
                              style: TextStyleUtils.regularDarkGray(16),
                            ),
                            TextField(
                              controller: bookingTimeController,
                              readOnly: true,
                              style: TextStyleUtils.boldDarkGray(16),
                              onTap: () {
                                _showTimePicker();
                              },
                              decoration: InputDecorationUtils.noBorder(
                                "Tentukan Waktu Penjemputan",
                                contentPadding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                // * Button
                ElevatedButton(
                  onPressed: () {
                    if (bookingLocationController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Pilih lokasi anda!"),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }
                    Navigator.of(context).pushNamed(
                      OrderTransportScreen.route,
                      arguments: <String, dynamic>{
                        "transport": transport,
                        "location": bookingLocationController.text,
                        "pickup_time": DateTime(
                          bookingDate.year,
                          bookingDate.month,
                          bookingDate.day,
                          bookingTime.hour,
                          bookingTime.minute,
                        ),
                      },
                    );
                  },
                  style: ButtonStyleUtils.activeButton,
                  child: Text(
                    "Pesan",
                    style: TextStyleUtils.semiboldWhite(16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
