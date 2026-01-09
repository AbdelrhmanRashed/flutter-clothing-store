part of 'products_cubit.dart';

sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsSuccess extends ProductsState {
  final List<ProductsModel> productsList;
  ProductsSuccess(this.productsList);
}

final class ProductsLoading extends ProductsState {}

final class ProductsFailure extends ProductsState {
  final String errMsg;
  ProductsFailure(this.errMsg);
}
