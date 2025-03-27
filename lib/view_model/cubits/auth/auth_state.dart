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

final class SendOtpLoadingState extends AuthState {}

final class SendOtpSuccessState extends AuthState {}

final class SendOtpErrorState extends AuthState {
  final String msg;

  SendOtpErrorState(this.msg);
}

final class ResendOtpLoadingState extends AuthState {}

final class ResendOtpSuccessState extends AuthState {}

final class ResendOtpErrorState extends AuthState {
  final String msg;

  ResendOtpErrorState(this.msg);
}

final class ChangePasswordVisibilityState extends AuthState {}

final class ChangeRememberMeState extends AuthState {}

final class ClearDataState extends AuthState {}

final class AuthGenderChanged extends AuthState {}

final class AuthDateChanged extends AuthState {
  final String formattedDate;

  AuthDateChanged(this.formattedDate);
}

final class AuthLogoutLoadingState extends AuthState {}

final class AuthLogoutSuccessState extends AuthState {}

class OtpTimerStartedState extends AuthState {}

class OtpTimerUpdatedState extends AuthState {
  final int remainingTime;

  OtpTimerUpdatedState(this.remainingTime);
}

class OtpTimerFinishedState extends AuthState {}

class ImagePickedState extends AuthState {
  final File? image;

  ImagePickedState(this.image);
}

final class AuthUpdateLoadingState extends AuthState {}

final class AuthUpdateSuccessState extends AuthState {}

final class AuthUpdateErrorState extends AuthState {
  final String msg;

  AuthUpdateErrorState(this.msg);
}

final class AuthGetDataLoadingState extends AuthState {}

class AuthGetDataSuccessState extends AuthState {
  final User user;

  AuthGetDataSuccessState(this.user);
}

final class AuthGetDataErrorState extends AuthState {
  final String msg;

  AuthGetDataErrorState(this.msg);
}

final class ChangePasswordLoadingState extends AuthState {}

final class ChangePasswordSuccessState extends AuthState {}

final class ChangePasswordErrorState extends AuthState {
  final String msg;

  ChangePasswordErrorState(this.msg);
}

final class GetCountriesLoadingState extends AuthState {}

final class GetCountriesSuccessState extends AuthState {}

final class GetCountriesErrorState extends AuthState {
  final String msg;

  GetCountriesErrorState(this.msg);
}

final class AddAddressLoadingState extends AuthState {}

final class AddAddressSuccessState extends AuthState {
  final String msg;

  AddAddressSuccessState(this.msg);
}

final class AddAddressErrorState extends AuthState {
  final String msg;

  AddAddressErrorState(this.msg);
}

final class UpdateAddressLoadingState extends AuthState {}

final class UpdateAddressSuccessState extends AuthState {
  final String msg;

  UpdateAddressSuccessState(this.msg);
}

final class UpdateAddressErrorState extends AuthState {
  final String msg;

  UpdateAddressErrorState(this.msg);
}

final class DeleteAddressLoadingState extends AuthState {}

final class DeleteAddressSuccessState extends AuthState {
  final String msg;

  DeleteAddressSuccessState(this.msg);
}

final class DeleteAddressErrorState extends AuthState {
  final String msg;

  DeleteAddressErrorState(this.msg);
}

final class CountryChanged extends AuthState {}

final class CityChanged extends AuthState {}

final class GetCitiesSuccessState extends AuthState {}
