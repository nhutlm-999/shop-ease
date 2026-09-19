import 'package:flutter/material.dart';
import 'package:shop_ease/app.dart';
// import 'package:shop_ease/repositories/product_repository.dart';

// void main() async {
//   final productRepository = ProductRepository();

//   try {
//     final products = await productRepository.getProducts();
//     print('Products:');
//     for (var product in products) {
//       print('ID: ${product.id}, Title: ${product.title}, Price: ${product.price}');
//     }
//   } catch (e) {
//     print('Error fetching products: $e');
//   }
// }

void main() {
  runApp(const ShopEaseApp());
}
