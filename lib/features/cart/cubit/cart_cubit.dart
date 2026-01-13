import 'package:Store/features/cart/widgets/cart_item.dart';
import 'package:Store/models/cart_model.dart';
import 'package:Store/models/products_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  final List<CartModel> cartItems = [];

  void addToCart(ProductsModel product) {
    final index = cartItems.indexWhere((item) => item.id == product.id);

    if (index != -1) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(
        CartModel(
          id: product.id,
          title: product.title,
          price: product.price,
          quantity: 1,
          image: product.thumbnail,
        ),
      );

      emit(CartUpdated(List.from(cartItems)));
    }
  }

  void removeItem(int id) {
    cartItems.removeWhere((item) => item.id == id);
    emit(CartUpdated(List.from(cartItems)));
  }

  void increment(int id) {
    final index = cartItems.indexWhere((item) => item.id == id);
    cartItems[index].quantity++;
    emit(CartUpdated(List.from(cartItems)));
  }

  void decrement(int id) {
    final index = cartItems.indexWhere((item) => item.id == id);
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      emit(CartUpdated(List.from(cartItems)));
    }
  }

  double get total => cartItems.fold(0, (sum, item) => sum + item.total);
}
