import 'package:dio/dio.dart';
import 'package:final_project/core/network/api_constants.dart';
import 'package:final_project/core/network/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/category_model.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  Future<void> getCategories() async {
    emit(CategoriesLoading());

    try {
      final response = await DioHelper.getRequest(
        endPoint: ApiConstants.categories,
      );
      final List<String> categoryNames = List<String>.from(response.data);

      final List<Future<CategoryModel>> tasks = categoryNames.map((
        category,
      ) async {
        try {
          final productResponse = await DioHelper.getRequest(
            endPoint: "${ApiConstants.productsCategory}/$category?limit=1",
          );
          final products = productResponse.data['products'] as List;
          final image =
              (products.isNotEmpty && products[0]['thumbnail'] != null)
              ? products[0]['thumbnail']
              : '';
          return CategoryModel(name: category, image: image);
        } catch (e) {
          return CategoryModel(name: category, image: '');
        }
      }).toList();

      final List<CategoryModel> categoriesResults = await Future.wait(tasks);

      List<CategoryModel> finalResult = [
        CategoryModel(
          image:
              'https://cdn.dummyjson.com/product-images/mens-shirts/man-short-sleeve-shirt/1.webp',
          name: "All",
        ),
        ...categoriesResults,
      ];

      emit(CategoriesSuccess(finalResult));
    } on DioException catch (e) {
      emit(CategoriesFailure(e.message ?? "Failed to get categories"));
    }
  }
}
