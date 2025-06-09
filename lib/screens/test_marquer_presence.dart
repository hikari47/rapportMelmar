import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;
//code pour verifier la connection sur android

class WifiCheckerScreen extends StatefulWidget {
  const WifiCheckerScreen({super.key});

  @override
  _WifiCheckerScreenState createState() => _WifiCheckerScreenState();
}

class _WifiCheckerScreenState extends State<WifiCheckerScreen> {
  String _connectionStatus = 'Vérification en cours...';
  final Connectivity _connectivity = Connectivity();
  final NetworkInfo _networkInfo = NetworkInfo();

  @override
  void initState() {
    super.initState();
    _checkWifiConnection();
  }
  
  Future<void> _checkWifiConnection() async {
    // Vérifier les permissions nécessaires
    if (Platform.isAndroid) {
      var status = await Permission.locationWhenInUse.request();
      if (status.isPermanentlyDenied) {
        setState(() {
          _connectionStatus = 'Permission de localisation refusée définitivement. Veuillez l\'activer dans les paramètres.';
        }); }
      if (status.isDenied) {
        setState(() {
          _connectionStatus = 'Permission de localisation refusée';
        });
        return;
      }
      }

    // Vérifier la connectivité
    var connectivityResult = await _connectivity.checkConnectivity();
    final wifiName = await _networkInfo.getWifiName();
    print('connectivityResult: $connectivityResult');
    print('connectivityResult name: $wifiName');
    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        // Obtenir le nom du réseau Wi-Fi (SSID)
        final wifiName = await _networkInfo.getWifiName();
        print('info wifi:${_networkInfo}');
        if (wifiName == 'Samy') {
          setState(() {
            _connectionStatus = 'Connecté au Wi-Fi "Samy"';
          });
        } else {
          setState(() {
            _connectionStatus = 'Connecté à un autre Wi-Fi: ${wifiName ?? "Inconnu"}';
          });
        }
      } catch (e) {
        setState(() {
          _connectionStatus = 'Erreur lors de la vérification du Wi-Fi: $e';
        });
      }
    } else {
      setState(() {
        _connectionStatus = 'Non connecté à un réseau Wi-Fi';
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vérification Wi-Fi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _connectionStatus,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkWifiConnection,
              child: const Text('Vérifier à nouveau'),
            ),
          ],
        ),
      ),
    );
  }
}
