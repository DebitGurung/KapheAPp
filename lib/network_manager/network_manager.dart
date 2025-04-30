import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kapheapp/utils/popups/loaders.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final RxList<ConnectivityResult> _connectionStatus =
      <ConnectivityResult>[].obs;
  bool _firstStatusCheck = true;

  @override
  void onInit() {
    super.onInit();
    _initNetworkManager();
  }

  Future<void> _initNetworkManager() async {
    try {
      await _checkInitialConnection();
      _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    } on PlatformException catch (e) {
      TLoader.errorSnackBar(
          title: 'Network Error',
          message: e.message ?? 'Failed to monitor network connectivity');
    }
  }

  Future<void> _checkInitialConnection() async {
    try {
      final List<ConnectivityResult> result =
          await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
      _firstStatusCheck = false;
    } on PlatformException catch (e) {
      TLoader.errorSnackBar(
          title: 'Network Error',
          message: e.message ?? 'Failed to check initial connection');
    }
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    _connectionStatus.value = results;
    bool isConnected = results.isNotEmpty && !results.contains(ConnectivityResult.none);
    if (!isConnected && !_firstStatusCheck) {
      TLoader.customToast(
          message: 'No Internet Connection',);
    }
  }

  Future<bool> isConnected() async {
    try {
      final List<ConnectivityResult> result = await _connectivity.checkConnectivity();
      return result.isNotEmpty && !result.contains(ConnectivityResult.none);
    } on PlatformException catch (e) {
      TLoader.errorSnackBar(
          title: 'Connection Error',
          message: e.message ?? 'Failed to check connection status');
      return false;
    }
  }

  Future<bool> isReallyConnected() async {
    try {
      // For actual internet verification, use:
      // return await InternetConnectionChecker().hasConnection;
      return await isConnected();
    } on Exception {
      return false;
    }
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
