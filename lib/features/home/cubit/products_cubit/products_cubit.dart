import 'package:dio/dio.dart';
import 'package:final_project/core/network/api_constants.dart';
import 'package:final_project/core/network/dio_helper.dart';
import 'package:final_project/models/products_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  Future<void> getProducts({required int limit}) async {
    emit(ProductsLoading());
    try {
      Response response = await DioHelper.getRequest(
        endPoint:
            "${ApiConstants.products}${limit != 0 ? "?limit=$limit" : ""}",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List productsJson = response.data['products'];

        List<ProductsModel> productsResponse = productsJson
            .map((product) => ProductsModel.fromJson(product))
            .toList();

        emit(ProductsSuccess(productsResponse));
      } else {
        emit(
          ProductsFailure(response.statusMessage ?? "Failed to get products!"),
        );
      }
    } on DioException catch (e) {
      emit(ProductsFailure(e.message ?? "Failed to get products!"));
    }
  }
}
