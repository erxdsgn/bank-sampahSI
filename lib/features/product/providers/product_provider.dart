import 'package:flutter/material.dart';
import '../model/product_model.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [
    Product(id: '1', name: 'Tas Plastik', price: 'Rp.20.000', imagePath: 'assets/images/tas1.png'),
    Product(id: '2', name: 'Kotak Tisu', price: 'Rp.10.000', imagePath: 'assets/images/tisu1.png'),
    Product(id: '3', name: 'Tas Plastik', price: 'Rp.20.000', imagePath: 'assets/images/tas2.png'),
    Product(id: '4', name: 'Kotak Tisu', price: 'Rp.10.000', imagePath: 'assets/images/tisu2.png'),
    Product(id: '5', name: 'Tas Plastik', price: 'Rp.20.000', imagePath: 'assets/images/tas1.png'),
    Product(id: '6', name: 'Kotak Tisu', price: 'Rp.10.000', imagePath: 'assets/images/tisu1.png'),
  ];

  List<Product> get products => _products;
}