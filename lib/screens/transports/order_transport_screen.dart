// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/models/transport_model.dart';
import 'package:trevago_app/screens/dashboard_screen.dart';
import 'package:trevago_app/screens/payment_screen.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/models/users.dart';
import 'package:trevago_app/widgets/custom_dialog_widget.dart';
import 'package:trevago_app/widgets/list_transport_card_widget.dart';

class OrderTransportScreen extends StatefulWidget {
  const OrderTransportScreen({super.key});

  static const String route = "/order_transport";

  @override
  State<OrderTransportScreen> createState() => _OrderTransportScreenState();
}

class _OrderTransportScreenState extends State<OrderTransportScreen> {
  static final NumberFormat formatter = NumberFormat("##,000");
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  late List<Map> paymentMethod;
  late Map selectedPaymentMethod;
  late TransportModel transport;
  late String location;
  late DateTime bookingDate;
  int participant = 1;
  int step = 1;

  String formatPrice(int price) => formatter.format(price).replaceAll(",", ".");

  @override
  void initState() {
    retrieveUserProfile(context);
    paymentMethod = <Map>[
      {
        "name": "indomaret",
        "image": ImageUtils.indomaret,
      },
      {
        "name": "alfamart",
        "image": ImageUtils.alfamart,
      },
    ];
    selectedPaymentMethod = paymentMethod[0];
    super.initState();
  }

  Future<void> retrieveUserProfile(context) async {
    try {
      final Users profile = await getProfile();
      setState(() {
        _nameTextController.text = profile.name;
        _phoneTextController.text = profile.phone;
        _emailTextController.text = profile.email;
      });
    } catch (error) {
      CustomDialogWidget.showErrorDialog(context, error.toString());
    }
  }

  Future<void> submitTransaction() async {
    try {
      CustomDialogWidget.showLoadingDialog(context);
      var res = await newTransactionTransport(
        transport.id,
        location,
        bookingDate,        
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: ColourUtils.blue,
          content: Text("Transaksi Berhasil!"),
        ),
      );
       Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => PaymentScreen(
                  directUrl: res["redirect_url"].toString(),
                  snapToken: res["snap_token"].toString(),
                )),
      ).then((_) => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DashboardScreen())));
    } catch (error) {
      Navigator.of(context).pop(); // Close Loading Dialog
      CustomDialogWidget.showErrorDialog(context, error.toString());
    }
  }

  List<Widget> renderPaymentMethod() {
    return paymentMethod.map(
      (val) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedPaymentMethod = val;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: selectedPaymentMethod == val
                        ? ColourUtils.blue
                        : Colors.transparent,
                    border: Border.all(
                      width: 1,
                      color: selectedPaymentMethod == val
                          ? ColourUtils.blue
                          : ColourUtils.gray,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                Image(
                  image: AssetImage(val["image"]),
                  height: 36,
                ),
              ],
            ),
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    transport = args["transport"];
    location = args["location"];
    bookingDate = args["pickup_time"];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.chevron_left),
          color: Colors.white,
        ),
        title: Text(
          "Pembayaran",
          style: TextStyleUtils.mediumWhite(20),
        ),
        backgroundColor: ColourUtils.blue,
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        children: [
          ExpansionTile(
            title: Text(
              "Metode Pembayaran",
              style: TextStyleUtils.mediumBlack(18),
            ),
            shape:
                const BeveledRectangleBorder(side: BorderSide.none),
            tilePadding: EdgeInsets.zero,
            initiallyExpanded: true,
            childrenPadding:
                const EdgeInsets.symmetric(horizontal: 16),
            children: [
              Column(
                children: renderPaymentMethod(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // *Divider
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.black45,
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.calendar_month,
                color: ColourUtils.darkGray,
              ),
              const SizedBox(width: 8),
              Text(
                DateFormat("EEE, dd MMM yyyy - hh:mm").format(bookingDate),
                style: TextStyleUtils.mediumDarkGray(16),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: ColourUtils.darkGray,
              ),
              const SizedBox(width: 8),
              Text(
                "Home",
                style: TextStyleUtils.mediumDarkGray(16),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ListTransportCardWidget(
            transport: transport,
            height: 120,
          ),
          const SizedBox(height: 24),
          // *Divider
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.black45,
          ),
          const SizedBox(height: 24),
          Text(
            "Detail Pemesan",
            style: TextStyleUtils.semiboldBlack(18),
          ),
          const SizedBox(height: 8),
          // *Name
          Text(
            "Nama Pemesan",
            style: TextStyleUtils.mediumDarkGray(16),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              _nameTextController.text,
              style: TextStyleUtils.regularBlue(16),
            ),
          ),
          const SizedBox(height: 8),
          // *Phone
          Text(
            "Nomor Telepon",
            style: TextStyleUtils.mediumDarkGray(16),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              _phoneTextController.text,
              style: TextStyleUtils.regularBlue(16),
            ),
          ),
          const SizedBox(height: 8),
          // *Email
          Text(
            "Email",
            style: TextStyleUtils.mediumDarkGray(16),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              _emailTextController.text,
              style: TextStyleUtils.regularBlue(16),
            ),
          ),
          const SizedBox(height: 24),
          // *Divider
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.black45,
          ),
          const SizedBox(height: 24),
          Text(
            "Detail",
            style: TextStyleUtils.semiboldBlack(18),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Harga Rental",
                style: TextStyleUtils.mediumBlack(16),
              ),
              Text(
                "Rp. ${formatPrice(transport.price)} / hari",
                style: TextStyleUtils.mediumBlue(16),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     Text(
          //       "Jumlah (Peserta)",
          //       style: TextStyleUtils.mediumBlack(16),
          //     ),
          //     Text(
          //       participant.toString(),
          //       style: TextStyleUtils.mediumBlue(16),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Total",
                style: TextStyleUtils.mediumBlack(18),
              ),
              Text(
                "Rp. ${formatPrice(transport.price)}",
                style: TextStyleUtils.boldBlue(18),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () {
            submitTransaction();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColourUtils.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text(
            "Bayar",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
