import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  final InternetConnectionChecker _internetChecker = InternetConnectionChecker.createInstance();
  bool _isInitialized = false;

  static ConnectivityCubit get(context) => BlocProvider.of<ConnectivityCubit>(context);

  ConnectivityCubit() : super(ConnectivityInitial()) {
    init();
  }

  Future<void> init() async {
    if (_isInitialized) return; // Prevent multiple initializations
    _isInitialized = true;

    await checkConnectivity();
    _connectivity.onConnectivityChanged.listen((result) async {
      await checkConnectivity();
    });
  }

  Future<void> checkConnectivity() async {
    emit(ConnectivityLoading()); // Emit loading state

    try {
      debugPrint('Checking network connectivity...');
      var connectivityResult = await _connectivity.checkConnectivity();
      bool hasNetwork = connectivityResult != ConnectivityResult.none;
      debugPrint('Network connectivity: $hasNetwork');

      if (!hasNetwork) {
        debugPrint('No network connection detected');
        emit(ConnectivityFailure(message: 'No network connection'));
        return;
      }

      debugPrint('Checking internet access...');
      bool hasInternet = await _internetChecker.hasConnection;
      debugPrint('Internet access: $hasInternet');

      // Emit the combined result
      bool isConnected = hasNetwork && hasInternet;
      emit(ConnectivitySuccess(isConnected));
    } catch (e) {
      debugPrint('Error checking connectivity: $e');
      emit(ConnectivityFailure(message: 'Failed to check connectivity: $e'));
    }
  }

  void dispose() {
    // Cancel any active listeners or streams if needed
  }
}