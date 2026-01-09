part of 'products_category_cubit.dart';


sealed class ProductsCategoryState {}

final class ProductsCategoryInitial extends ProductsCategoryState {}
final class ProductsCategorySuccess extends ProductsCategoryState {
  final List<ProductsModel> productsList;
  ProductsCategorySuccess(this.productsList);
}

final class ProductsCategoryLoading extends ProductsCategoryState {}

final class ProductsCategoryFailure extends ProductsCategoryState {
  final String errMsg;
  ProductsCategoryFailure(this.errMsg);
}