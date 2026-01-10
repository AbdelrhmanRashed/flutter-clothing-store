part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}
class AuthUserLoading extends AuthState {}
final class AuthUserLoaded extends AuthState {
  UserModel? user;
  AuthUserLoaded(this.user);
}
final class AuthLoggedOut extends AuthState {}

