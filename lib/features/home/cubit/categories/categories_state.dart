part of 'categories_cubit.dart';


sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}
final class CategoriesSuccess extends CategoriesState {
  final List<String> categoriesList;
  CategoriesSuccess(this.categoriesList);

}
final class CategoriesLoading extends CategoriesState {}
final class CategoriesFailure extends CategoriesState {
  final String errMsg;
  CategoriesFailure(this.errMsg);
}
