part of 'search_cubit.dart';

sealed class SearchState {}

final class SearchInitial extends SearchState {}
final class SearchLoading extends SearchState {}
final class SearchSuccess extends SearchState {
  List<ProductsModel> productsList;
  SearchSuccess(this.productsList);
}
final class SearchFailure extends SearchState {
  String errMsg;
  SearchFailure(this.errMsg);
}
final class SearchEmpty extends SearchState {}
