import 'package:test_projectt/feature/home/models/products_list_model.dart';

class CartItem {
  Products product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  Map<String, dynamic> toJson() {
    return {'product': product.toJson(), 'quantity': quantity};
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Products.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}
