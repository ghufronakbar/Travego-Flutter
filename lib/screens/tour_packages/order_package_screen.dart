// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:trevago_app/configs/api/api.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/models/tour_package_model.dart';
import 'package:trevago_app/screens/payment_screen.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/models/users.dart';
import 'package:trevago_app/screens/dashboard_screen.dart';
import 'package:trevago_app/widgets/custom_dialog_widget.dart';
import 'package:trevago_app/widgets/step_indicator_widget.dart';

class OrderPackageScreen extends StatefulWidget {
  const OrderPackageScreen({super.key});

  static const String route = "/order_package";

  @override
  State<OrderPackageScreen> createState() => _OrderPackageScreenState();
}

class _OrderPackageScreenState extends State<OrderPackageScreen> {
  static final NumberFormat formatter = NumberFormat("##,000");
  final PageController _pageController = PageController(initialPage: 0);
  final TextEditingController _dateTextController = TextEditingController();
  final TextEditingController _participantTextController =
      TextEditingController(text: "1");
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _noteTextController = TextEditingController();
  late List<Map> paymentMethod;
  late Map selectedPaymentMethod;
  late TourPackageModel package;
  late int package_price;
  DateTime selectedDate = DateTime.now();
  int participant = 1;
  int step = 1;

  String formatPrice(int price) => formatter.format(price).replaceAll(",", ".");

  @override
  void initState() {
    _dateTextController.text =
        DateFormat("dd MMMM yyyy").format(DateTime.now());
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
      _nameTextController.text = profile.name;
      _phoneTextController.text = profile.phone;
      _emailTextController.text = profile.email;
    } catch (error) {
      CustomDialogWidget.showErrorDialog(context, error.toString());
    }
  }

  Future<void> submitTransaction() async {
    try {
      CustomDialogWidget.showLoadingDialog(context);
      var res = await newTransactionPackage(
        selectedDate,
        _noteTextController.text,
        package.id,
        participant,
        package_price,
        participant * package_price,
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

  void handleSubmit() async {
    if (step <= 1) {
      if (participant < 1) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Isi jumlah peserta!"),
          backgroundColor: Colors.black,
        ));
        return;
      }
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        step = 2;
      });
    } else if (step <= 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        step = 3;
      });
    } else {
      submitTransaction();
    }
  }

  Future<void> selectDate() async {
    DateTime? date;
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
              minimumDate: DateTime.now(),
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (val) {
                date = DateTime(val.year, val.month, val.day);
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
              if (date != null) {
                setState(() {
                  selectedDate = date!;
                  _dateTextController.text =
                      DateFormat("dd MMMM yyyy").format(selectedDate);
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
    package = ModalRoute.of(context)!.settings.arguments as TourPackageModel;
    package_price = package.price;
    return PopScope(
      canPop: step == 1,
      onPopInvoked: (poped) {
        if (poped) {
          return;
        }
        setState(() {
          step -= 1;
        });
        _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.chevron_left),
            color: ColourUtils.blue,
          ),
          title: Text(
            step == 1
                ? "Informasi Pesanan"
                : (step == 2 ? "Informasi Data Diri" : "Metode Pembayaran"),
            style: TextStyleUtils.regularBlack(18),
          ),
          scrolledUnderElevation: 0,
        ),
        body: Column(
          children: [
            Container(
              height: 64,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 8,
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        margin: const EdgeInsets.only(top: 14),
                        width: 96,
                        height: 2,
                        duration: const Duration(milliseconds: 750),
                        color:
                            step > 1 ? ColourUtils.blue : ColourUtils.lightGray,
                        curve: Curves.easeInOut,
                      ),
                      AnimatedContainer(
                        margin: const EdgeInsets.only(top: 14),
                        width: 80,
                        height: 2,
                        duration: const Duration(milliseconds: 750),
                        color:
                            step > 2 ? ColourUtils.blue : ColourUtils.lightGray,
                        curve: Curves.easeInOut,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (step >= 1) {
                            _pageController.animateToPage(
                              0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                            setState(() {
                              step = 1;
                            });
                          }
                        },
                        child: StepIndicatorWidget(
                          currentStep: step,
                          stepNumber: 1,
                          label: "Pesan",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (step >= 2) {
                            _pageController.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                            setState(() {
                              step = 2;
                            });
                          }
                        },
                        child: StepIndicatorWidget(
                          currentStep: step,
                          stepNumber: 2,
                          label: "Data Diri",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (step >= 3) {
                            _pageController.animateToPage(
                              2,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                            setState(() {
                              step = 3;
                            });
                          }
                        },
                        child: StepIndicatorWidget(
                          currentStep: step,
                          stepNumber: 3,
                          label: "Pembayaran",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // *Form 1
                  ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.25),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tanggal Pilihan",
                              style: TextStyleUtils.semiboldBlack(16),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _dateTextController,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 2,
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: ColourUtils.gray),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    selectDate();
                                  },
                                  icon: const Icon(Icons.calendar_month),
                                  color: ColourUtils.blue,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.25),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jumlah Peserta",
                              style: TextStyleUtils.semiboldBlack(16),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Rp. ${formatPrice(package.price)} / orang",
                                    style: TextStyleUtils.semiboldBlue(16),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (_participantTextController
                                        .text.isNotEmpty) {
                                      participant == 0 ? 0 : participant--;
                                    } else {
                                      participant = 0;
                                    }
                                    setState(() {
                                      _participantTextController.text =
                                          participant.toString();
                                    });
                                  },
                                  icon: const Icon(Icons.remove),
                                  color: ColourUtils.blue,
                                ),
                                SizedBox(
                                  width: 32,
                                  child: TextField(
                                    controller: _participantTextController,
                                    onChanged: (val) {
                                      setState(() {
                                        if (val.isNotEmpty) {
                                          participant = int.tryParse(val) ?? 0;
                                        } else {
                                          participant = 0;
                                        }
                                      });
                                    },
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(5),
                                    ],
                                    decoration: InputDecorationUtils
                                        .underlineDefaultBorder(""),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (_participantTextController
                                        .text.isNotEmpty) {
                                      participant++;
                                    } else {
                                      participant = 1;
                                    }
                                    setState(() {
                                      _participantTextController.text =
                                          participant.toString();
                                    });
                                  },
                                  icon: const Icon(Icons.add),
                                  color: ColourUtils.blue,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 148,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${ApiConfig.tour_package_storage}/${package.tour.image}"),
                              fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.25),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 16,
                          ),
                          color: Colors.white,
                          child: Text(
                            package.title,
                            softWrap: true,
                            style: TextStyleUtils.mediumBlack(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // *Form 2
                  ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    children: [
                      // *Name
                      Text(
                        "Nama Pemesan",
                        style: TextStyleUtils.semiboldBlack(14),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: _nameTextController,
                        readOnly: true,
                        style: TextStyleUtils.regularBlack(14),
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100),
                        ],
                        cursorColor: ColourUtils.blue,
                        decoration: InputDecorationUtils.outlinedGrayBorder(
                            "Nama Pemesan"),
                      ),
                      const SizedBox(height: 12),
                      // *Phone
                      Text(
                        "Nomor Telepon",
                        style: TextStyleUtils.semiboldBlack(14),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: _phoneTextController,
                        readOnly: true,
                        style: TextStyleUtils.regularBlack(14),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(15),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        cursorColor: ColourUtils.blue,
                        decoration: InputDecorationUtils.outlinedGrayBorder(
                            "Nomor Telepon"),
                      ),
                      const SizedBox(height: 12),
                      // *Email
                      Text(
                        "Email",
                        style: TextStyleUtils.semiboldBlack(14),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: _emailTextController,
                        readOnly: true,
                        style: TextStyleUtils.regularBlack(14),
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100),
                        ],
                        cursorColor: ColourUtils.blue,
                        decoration:
                            InputDecorationUtils.outlinedGrayBorder("Email"),
                      ),
                      const SizedBox(height: 12),
                      // *Notes
                      Text(
                        "Catatan",
                        style: TextStyleUtils.semiboldBlack(14),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: _noteTextController,
                        style: TextStyleUtils.regularBlack(14),
                        keyboardType: TextInputType.multiline,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(500),
                        ],
                        minLines: 4,
                        maxLines: 4,
                        cursorColor: ColourUtils.blue,
                        decoration: InputDecorationUtils.outlinedGrayBorder(
                            "Catatan (Opsional)"),
                      ),
                    ],
                  ),
                  // *Form 3
                  ListView(
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
                        childrenPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          Column(
                            children: renderPaymentMethod(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.shopping_bag,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            package.title,
                            style: TextStyleUtils.mediumBlack(16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat("EEE, dd MMM yyyy").format(selectedDate),
                            style: TextStyleUtils.mediumBlack(16),
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
                      Text(
                        "Detail Pemesan",
                        style: TextStyleUtils.semiboldBlack(18),
                      ),
                      const SizedBox(height: 8),
                      // *Name
                      Text(
                        "Nama Pemesan",
                        style: TextStyleUtils.mediumBlack(16),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          _nameTextController.text,
                          style: TextStyleUtils.regularBlack(16),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // *Phone
                      Text(
                        "Nomor Telepon",
                        style: TextStyleUtils.mediumBlack(16),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          _phoneTextController.text,
                          style: TextStyleUtils.regularBlack(16),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // *Email
                      Text(
                        "Email",
                        style: TextStyleUtils.mediumBlack(16),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          _emailTextController.text,
                          style: TextStyleUtils.regularBlack(16),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // *Notes
                      Text(
                        "Catatan",
                        style: TextStyleUtils.mediumBlack(16),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          _noteTextController.text,
                          softWrap: true,
                          style: TextStyleUtils.regularBlack(16),
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
                            "Paket",
                            style: TextStyleUtils.mediumBlack(16),
                          ),
                          Text(
                            "Rp. ${formatPrice(package.price)} / orang",
                            style: TextStyleUtils.mediumBlue(16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Jumlah (Peserta)",
                            style: TextStyleUtils.mediumBlack(16),
                          ),
                          Text(
                            participant.toString(),
                            style: TextStyleUtils.mediumBlue(16),
                          ),
                        ],
                      ),
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
                            "Rp. ${formatPrice(participant * package_price)}",
                            style: TextStyleUtils.boldBlue(16),
                          ),
                        ],
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
          child: ElevatedButton(
            onPressed: () {
              handleSubmit();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColourUtils.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              step >= 3 ? "Pesan Sekarang" : "Selanjutnya",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
