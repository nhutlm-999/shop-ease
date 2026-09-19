// 1.4 Xây dựng StreamController cho giỏ hàng (emit mỗi khi thêm/xóa)
// final cartStream = StreamController<List<CartItem>>.broadcast()

import 'dart:async';
import 'package:shop_ease/models/cart_item.dart';

class CartRepository {
  // Stream để các widget lắng nghe thay đổi giỏ hàng
  final _cartController = StreamController<List<CartItem>>.broadcast();

  // Widget dùng cái này để lắng nghe
  Stream<List<CartItem>> get cartStream => _cartController.stream;

  // Thêm sản phẩm vào giỏ hàng
  final List<CartItem> _cartItems = [];

  void addItem (CartItem item) {
    _cartItems.add(item);
    _cartController.add(_cartItems); // Emit danh sách giỏ hàng mới -> UI tự update
  }

  void removeItem (String productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
    _cartController.add(_cartItems); // Emit danh sách giỏ hàng mới -> UI tự update
  }

  void dispose() {
    _cartController.close();
  }

}

// ++ Trong CartScreen
// StreamBuilder<List<CartItem>>(
//   stream: cartRepository.cartStream,
//   builder: (context, snapshot) {
//     final items = snapshot.data ?? [];
//     return Text('Giỏ hàng: ${items.length} sản phẩm');
//   },
// )