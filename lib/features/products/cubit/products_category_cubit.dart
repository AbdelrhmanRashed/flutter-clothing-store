import 'package:dio/dio.dart';
import 'package:final_project/core/network/api_constants.dart';
import 'package:final_project/core/network/dio_helper.dart';
import 'package:final_project/models/products_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_category_state.dart';

class ProductsCategoryCubit extends Cubit<ProductsCategoryState> {
  ProductsCategoryCubit() : super(ProductsCategoryInitial());
  Future<void> getProductsCategory({required String category}) async {
    emit(ProductsCategoryLoading());
    try {
      Response response;

      if(category == "All") {
        response = await DioHelper.getRequest(
          endPoint:
          "${ApiConstants.products}?limit=120",
        );
      }
      else {
        response = await DioHelper.getRequest(
          endPoint:
          "${ApiConstants.productsCategory}/$category",
        );
      }


      if (response.statusCode == 200 || response.statusCode == 201) {
        final List productsJson = response.data['products'];

        List<ProductsModel> productsResponse = productsJson
            .map((product) => ProductsModel.fromJson(product))
            .toList();

        emit(ProductsCategorySuccess(productsResponse));
      } else {
        emit(
          ProductsCategoryFailure(response.statusMessage ?? "Failed to get products!"),
        );
      }
    } on DioException catch (e) {
      emit(ProductsCategoryFailure(e.message ?? "Failed to get products!"));
    }
  }
}
