import 'package:final_project/core/helper/cache_helper.dart';
import 'package:final_project/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  UserModel? user;

  Future<void> loadUser() async {
    emit(AuthUserLoading());
    user = await CacheHelper.getUser();
    emit(AuthUserLoaded(user));
  }

  Future<void> logout() async {
    await CacheHelper.deleteUser();
    await CacheHelper.deleteToken();
    emit(AuthLoggedOut());
  }
}
