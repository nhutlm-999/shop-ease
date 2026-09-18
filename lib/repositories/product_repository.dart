// 1.2 Tạo ProductRepository với các method async:
// + Future<List<Product>> getProducts()
// + Future<List<Product>> getByCategory(String cat)
// + Future<Product> getById(int id)
// ** Dùng API thật: https://fakestoreapi.com/products

import 'dart:convert';
import 'package:shop_ease/models/product.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  final String baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      List<Product> products = body.map((dynamic item) => Product.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product>> getByCategory(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/category/$category'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products by category');
    }
  }

  Future<Product> getById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Product.fromJson(data);
    } else {
      throw Exception('Failed to load product by id');
    }
  }
}