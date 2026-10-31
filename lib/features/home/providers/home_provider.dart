import 'package:flutter/material.dart';
import '../models/home_model.dart';
import '../models/transaction.dart'; // Import Transaction

class HomeProvider with ChangeNotifier {
  HomeData? _homeData;
  HomeData? get homeData => _homeData;

  Future<void> fetchHomeData() async {
    await Future.delayed(const Duration(seconds: 1));

    _homeData = HomeData(
      userName: "ERIX AGUNG WIBOWO",
      balance: "Rp 800.000,00",
      accountNumber: "8800 8181 8008",
      transactions: [
        const Transaction(title: "Setoran Sampah Plastik", amount: 12000),
        const Transaction(title: "Setoran Sampah Kertas", amount: 8000),
        const Transaction(title: "Setoran Sampah Plastik", amount: 15000),
      ],
    );
    notifyListeners();
  }
}