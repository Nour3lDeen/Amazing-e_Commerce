part of 'connectivity_cubit.dart';

abstract class ConnectivityState {}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivityLoading extends ConnectivityState {}

class ConnectivitySuccess extends ConnectivityState {
  final bool isConnected;
  ConnectivitySuccess(this.isConnected);
}

class ConnectivityFailure extends ConnectivityState {
  final String message;
  ConnectivityFailure({required this.message});
}