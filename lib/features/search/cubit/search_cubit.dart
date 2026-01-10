import 'package:dio/dio.dart';
import 'package:final_project/core/network/api_constants.dart';
import 'package:final_project/core/network/dio_helper.dart';
import 'package:final_project/models/products_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  String currentQuery = '';

  SearchCubit() : super(SearchInitial());

  Future<void> getSearchResults({required String query}) async {
    currentQuery = query;
    if (query.trim().isEmpty) return emit(SearchEmpty());

    emit(SearchLoading());

    try {
      final response = await DioHelper.getRequest(
        endPoint: "${ApiConstants.search}?q=$query",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List productsJson = response.data['products'] ?? [];

        if (productsJson.isEmpty) return emit(SearchEmpty());

        final products = productsJson
            .map((product) => ProductsModel.fromJson(product))
            .toList();

        if (query != currentQuery) return;
        emit(SearchSuccess(products));
      } else {
        emit(
          SearchFailure(response.statusMessage ?? "Failed to get products!"),
        );
      }
    } on DioException catch (e) {
      emit(SearchFailure(e.message ?? "Network error!"));
    }
  }
}
