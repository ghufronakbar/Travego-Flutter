// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/screens/welcome_screen.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/screens/tour_packages/detail_order_package_screen.dart';

class OrderedMenu extends StatefulWidget {
  const OrderedMenu({super.key});

  @override
  State<OrderedMenu> createState() => _OrderedMenuState();
}

class _OrderedMenuState extends State<OrderedMenu> {
  static final NumberFormat formatter = NumberFormat("##,000");

  String formatPrice(int price) => formatter.format(price).replaceAll(",", ".");

  @override
  void initState() {
    super.initState();
  }

  Future<List> retrieveTransactions() async {
    try {
      final List transactions = await getTransactionsPackage();
      return transactions;
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Terjadi Kesalahan!"),
          content: Text("$error"),
          actions: [
            TextButton(
              onPressed: () async {
                if (error.toString().contains("Forbidden")) {
                  await logoutAction();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    WelcomeScreen.route,
                    (route) => false,
                  );
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: const Text("OKE"),
            ),
          ],
        ),
      );
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Daftar Pesanan"),
      ),
      body: FutureBuilder(
        future: retrieveTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  DetailOrderPackageScreen.route,
                  arguments: snapshot.data![index],
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: .5,
                    color: Colors.black38,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.25),
                      blurRadius: 4,
                      offset: const Offset(.5, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "ID Pesanan ${snapshot.data![index]["id_pesanan"]}",
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Rp. ${formatPrice(snapshot.data![index]["total"])}",
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                color: ColourUtils.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      color: ColourUtils.lightGray,
                      child: Row(
                        children: [
                          const Icon(Icons.landscape),
                          const SizedBox(width: 8),
                          Text(
                            snapshot.data![index]["nama_paket"],
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              snapshot.data![index]["status"],
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: ColourUtils.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
    );
  }
}
