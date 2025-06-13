import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;

class PresenceScreen extends StatefulWidget {
  const PresenceScreen({super.key});

  @override
  _PresenceScreenState createState() => _PresenceScreenState();
}

class _PresenceScreenState extends State<PresenceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _connectionStatus = 'Vérification en cours...';
  final Connectivity _connectivity = Connectivity();
  final NetworkInfo _networkInfo = NetworkInfo();
  bool _isCheckingWifi = false;

  @override
  void initState() {
    super.initState();
    _checkInitialConnection();
  }

  Future<void> _checkInitialConnection() async {
    if (Platform.isAndroid) {
      var status = await Permission.locationWhenInUse.request();
      if (status.isPermanentlyDenied) {
        setState(() {
          _connectionStatus = 'Permission de localisation refusée définitivement. Veuillez l\'activer dans les paramètres.';
        });
        return;
      }
      if (status.isDenied) {
        setState(() {
          _connectionStatus = 'Permission de localisation refusée';
        });
        return;
      }
    }
    await _checkWifiConnection();
  }

  Future<void> _checkWifiConnection() async {
    setState(() {
      _isCheckingWifi = true;
    });
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        final wifiName = await _networkInfo.getWifiName();
        if (wifiName == 'Samy') {
          setState(() {
            _connectionStatus = 'Vous êtes connecté au Wi-Fi de l\'entreprise "Samy"';
            _isCheckingWifi = false;
          });
        } else {
          setState(() {
            _connectionStatus = 'Veuillez vous connecter au Wi-Fi "Samy"';
            _isCheckingWifi = false;
          });
        }
      } catch (e) {
        setState(() {
          _connectionStatus = 'Erreur lors de la vérification du Wi-Fi: $e';
          _isCheckingWifi = false;
        });
      }
    } else {
      setState(() {
        _connectionStatus = 'Veuillez vous connecter à un réseau Wi-Fi';
        _isCheckingWifi = false;
      });
    }
  }

  // Méthode pour attendre la connexion au Wi-Fi spécifique et valider
  Future<void> _waitForWifiAndLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isCheckingWifi = true;
      _connectionStatus = 'Vérification de la connexion Wi-Fi...';
    });

    while (true) {
      var connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi)) {
        final wifiName = await _networkInfo.getWifiName();
        if (wifiName == 'Samy') {
          setState(() {
            _connectionStatus = 'Vous êtes connecté au Wi-Fi de l\'entreprise "Samy"';
            _isCheckingWifi = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Connexion réussie ! Bienvenue, ${_usernameController.text}.')),
          );
          break;
        } else {
          setState(() {
            _connectionStatus = 'Veuillez vous connecter au Wi-Fi "Samy"';
          });
          await Future.delayed(Duration(seconds: 2)); // Vérification toutes les 2 secondes
        }
      } else {
        setState(() {
          _connectionStatus = 'Veuillez vous connecter à un réseau Wi-Fi';
        });
        await Future.delayed(Duration(seconds: 2));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connexion')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Vérification Wi-Fi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                _connectionStatus,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              if (_isCheckingWifi) CircularProgressIndicator(),
              SizedBox(height: 20),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Nom d\'utilisateur'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom d\'utilisateur';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un mot de passe';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _waitForWifiAndLogin,
                child: Text('Se connecter'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: _checkWifiConnection,
                child: Text('Vérifier la connexion Wi-Fi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

