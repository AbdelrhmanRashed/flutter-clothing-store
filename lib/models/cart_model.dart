import 'package:final_project/models/products_model.dart';

class CartModel {
  final int id;
  final String title;
  final double price;
  final String image;
  int quantity;

  CartModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
  });

  factory CartModel.fromProduct(ProductsModel product) {
    return CartModel(
      id: product.id,
      title: product.title,
      price: product.price,
      image: product.thumbnail,
      quantity: 1,
    );
  }

  double get total => price * quantity;

  Map<String, dynamic> toApiJson() {
    return {
      "id": id,
      "quantity": quantity,
    };
  }
}
