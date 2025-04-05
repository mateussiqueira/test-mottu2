
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ConnectivityStatus { online, offline }

class ConnectivityService extends GetxService {
  final _connectionStatus = ConnectivityStatus.online.obs;

  ConnectivityStatus get status => _connectionStatus.value;
  Stream<ConnectivityStatus> get statusStream => _connectionStatus.stream;

  // Método simulado para verificar conectividade
  Future<bool> checkConnectivity() async {
    try {
      // Em uma aplicação real, usaríamos o package connectivity_plus
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateConnectionStatus() async {
    final isConnected = await checkConnectivity();
    _connectionStatus.value = isConnected 
        ? ConnectivityStatus.online 
        : ConnectivityStatus.offline;
  }

  @override
  void onInit() {
    super.onInit();
    
    // Verificar a cada 30 segundos
    Timer.periodic(const Duration(seconds: 30), (_) {
      updateConnectionStatus();
    });
    
    // Verificação inicial
    updateConnectionStatus();
  }
}
