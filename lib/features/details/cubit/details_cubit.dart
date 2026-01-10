import 'package:dio/dio.dart';
import 'package:final_project/core/network/api_constants.dart';
import 'package:final_project/core/network/dio_helper.dart';
import 'package:final_project/models/products_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  Future<void> getProductDetails({required int id}) async {
    emit(DetailsLoading());

    try {
      final response = await DioHelper.getRequest(
        endPoint: "${ApiConstants.productDetails}$id",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ProductsModel productDetails = ProductsModel.fromJson(response.data);

        emit(DetailsSuccess(productDetails));
      } else {
        emit(
          DetailsFailure(
            response.statusMessage ?? "Failed to get product details!",
          ),
        );
      }
    } on DioException catch (e) {
      emit(DetailsFailure(e.message ?? "Network error!"));
    }
  }
}
