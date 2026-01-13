import 'package:dio/dio.dart';
import 'package:Store/core/helper/cache_helper.dart';
import 'package:Store/core/network/api_constants.dart';
import 'package:Store/core/network/dio_error_mapper.dart';
import 'package:Store/core/network/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/user_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  bool rememberMe = false;

  void toggleRememberMe(bool value) {
    rememberMe = value;
    emit(RememberMeChanged());
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      final response = await DioHelper.postRequest(
        endPoint: ApiConstants.loginEndPoint,
        data: {"username": username, "password": password},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = UserModel.fromJson(response.data);
        if (model.accessToken == null) {
          return emit(LoginFailure("No token found!"));
        }
        if (rememberMe) {
          await CacheHelper.saveToken(model.accessToken!);
        }
        await CacheHelper.saveUser(model);

        emit(LoginSuccess());
      }
    } on DioException catch (e) {
      emit(LoginFailure("Username or password is incorrect"));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
