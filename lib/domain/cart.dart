import 'package:surf/domain/product.dart';

class CartInfo {
  final List<CartItem> products;

  CartInfo({
    required this.products,
  });
}

class CartItem {
  final Product product;
  final int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}
