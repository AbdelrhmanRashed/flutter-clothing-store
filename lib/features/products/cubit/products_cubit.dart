import 'package:dio/dio.dart';
import 'package:final_project/core/network/api_constants.dart';
import 'package:final_project/core/network/dio_helper.dart';
import 'package:final_project/models/products_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  static const allCategory = 'All';

  Future<void> getProducts({required String category}) async {
    emit(ProductsLoading());

    try {
      final String endPoint = category == allCategory
          ? "${ApiConstants.products}?limit=99999"
          : "${ApiConstants.productsCategory}/$category";

      final response = await DioHelper.getRequest(endPoint: endPoint);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List productsJson = response.data['products'] ?? [];

        final products = productsJson
            .map((product) => ProductsModel.fromJson(product))
            .toList();

        emit(ProductsSuccess(products));
      } else {
        emit(
          ProductsFailure(
            response.statusMessage ?? "Failed to get product!",
          ),
        );
      }
    } on DioException catch (e) {
      emit(ProductsFailure(e.message ?? "Network error!"));
    }
  }
}

