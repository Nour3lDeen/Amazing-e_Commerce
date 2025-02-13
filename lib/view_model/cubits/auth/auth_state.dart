part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoadingState extends AuthState {}

final class LoginSuccessState extends AuthState {}

final class LoginErrorState extends AuthState {
  final String msg;

  LoginErrorState(this.msg);
}

final class RegisterLoadingState extends AuthState {}

final class RegisterSuccessState extends AuthState {}

final class RegisterErrorState extends AuthState {
  final String msg;

  RegisterErrorState(this.msg);
}

final class ChangePasswordVisibilityState extends AuthState {}

final class ChangeRememberMeState extends AuthState {}

final class AuthGenderChanged extends AuthState {}

final class AuthDateChanged extends AuthState {
  final String formattedDate;

  AuthDateChanged(this.formattedDate);
}

final class AuthLogoutSuccessState extends AuthState {}
