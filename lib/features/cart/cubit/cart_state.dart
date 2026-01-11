part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}
final class CartUpdated extends CartState {
  List<CartModel> cartItems;
  CartUpdated(this.cartItems);
}
