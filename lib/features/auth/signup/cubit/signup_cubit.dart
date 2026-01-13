import 'package:dio/dio.dart';
import 'package:Store/core/helper/cache_helper.dart';
import 'package:Store/core/network/api_constants.dart';
import 'package:Store/core/network/dio_error_mapper.dart';
import 'package:Store/core/network/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/user_model.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  Future<void> signUp({
    required String username,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    emit(SignupLoading());
    try {
      final response = await DioHelper.postRequest(
        endPoint: ApiConstants.signUpEndPoint,
        data: {
          "image": "https://dummyjson.com/icon/emmaj/128",
          "username": username,
          "firstName": firstName,
          "lastName": lastName,
          "password": password,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = UserModel.fromJson(response.data);

        await CacheHelper.saveUser(model);
        await CacheHelper.saveToken("fake-token");

        emit(SignupSuccess());
      }
    } on DioException catch (e) {
      emit(SignupFailure(DioErrorMapper.handleError(e)));
    } catch (e) {
      emit(SignupFailure(e.toString()));
    }
  }
}
