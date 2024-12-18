// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trevago_app/screens/menu/ordered_menu.dart';
import 'package:trevago_app/screens/payment_screen.dart';
import 'package:trevago_app/utils/utils.dart';

class DetailOrderPackageScreen extends StatelessWidget {
  DetailOrderPackageScreen({super.key});

  static const String route = '/detail_order_package_screen';
  static NumberFormat formatter = NumberFormat("##,000");
  late Map package_transaction;

  String dateToString(DateTime date) {
    return DateFormat("dd MMM yyyy").format(date);
  }

  String formatPrice(int price) => formatter.format(price).replaceAll(",", ".");


  @override
  Widget build(BuildContext context) {
    package_transaction = ModalRoute.of(context)!.settings.arguments as Map;
  void handleOnPayTap() {
    Navigator.of(context)
        .pushReplacement(
          MaterialPageRoute(
              builder: (context) => PaymentScreen(
                    directUrl: package_transaction["redirect_url"].toString(),
                    snapToken: package_transaction["snap_token"].toString(),
                  )),
        )
        .then((_) => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const OrderedMenu())));
  }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text(
          "Detail Transaksi",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 12),
          // ! Transaction Info
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.black.withOpacity(.15),
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ? Transaction Number
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Nomor Transaksi",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      package_transaction["id_pesanan"].toString(),
                      style: const TextStyle(
                        color: ColourUtils.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    decoration: BoxDecoration(
                      color: ColourUtils.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      package_transaction["status"].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // ! Customer Info
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.black.withOpacity(.15),
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ? Customer name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Nama",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      package_transaction["nama"],
                      style: const TextStyle(
                        color: ColourUtils.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // ? Customer phone number
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Nomor Telepon",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      package_transaction["no_hp"],
                      style: const TextStyle(
                        color: ColourUtils.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // ? Customer Email
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      package_transaction["email"],
                      style: const TextStyle(
                        color: ColourUtils.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // ! Order Info
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.black.withOpacity(.15),
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ? Note
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Catatan",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      package_transaction["catatan"]?.isNotEmpty
                          ? package_transaction["catatan"]
                          : "Tidak ada catatan",
                      style: const TextStyle(
                        color: ColourUtils.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // ? Order Date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tanggal Pemesanan",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateToString(
                        DateTime.parse(package_transaction["tgl_pesanan"]),
                      ),
                      style: const TextStyle(
                        color: ColourUtils.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // ? Product Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Paket",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black.withOpacity(.25),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  package_transaction["nama_paket"],
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Rp. ${formatPrice(package_transaction["harga"])}",
                                  style: const TextStyle(
                                    color: ColourUtils.blue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "x ${package_transaction["qty"]}",
                            style: const TextStyle(
                              color: ColourUtils.blue,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 4),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.all(8),
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Colors.black.withOpacity(.15),
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total Pembayaran",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Rp. ${formatPrice(package_transaction["total"])}",
                      style: const TextStyle(
                        color: ColourUtils.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              package_transaction["status"] == "Menunggu Pembayaran" ?
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColourUtils.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: handleOnPayTap,
                    child: const Text("Lanjutkan Pembayaran",
                        style: TextStyle(color: Colors.white)),
                    ),
              ): const SizedBox()
            ],
          )),
    );
  }
}
