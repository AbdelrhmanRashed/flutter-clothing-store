part of 'categories_cubit.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final List<CategoryModel> categories;

  CategoriesSuccess(this.categories);
}

class CategoriesFailure extends CategoriesState {
  final String errMsg;

  CategoriesFailure(this.errMsg);
}
