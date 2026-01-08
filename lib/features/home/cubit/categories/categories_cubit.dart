import 'package:dio/dio.dart';
import 'package:final_project/core/network/api_constants.dart';
import 'package:final_project/core/network/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  Future<void> getCategories() async {
    emit(CategoriesLoading());
    try {
      Response response = await DioHelper.getRequest(
        endPoint: ApiConstants.categories,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final categoriesList = List<String>.from(response.data);
        emit(CategoriesSuccess(categoriesList));
      } else {
        emit(
          CategoriesFailure(
            response.statusMessage ?? "Failed to get Categories!",
          ),
        );
      }
    } on DioException catch (e) {
      emit(CategoriesFailure(e.message ?? "Failed to get Categories!"));
    }
  }
}
