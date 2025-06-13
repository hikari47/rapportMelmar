import 'dart:convert';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';

class QRCodeGeneration extends StatelessWidget {
  final List<Map<String,dynamic>> products;
  final String clientName;
  final DateTime purchaseDate;

  
  const QRCodeGeneration({
    Key? key,
    required this.products,
    required this.clientName,
    required this.purchaseDate,
  }) : super(key: key);

  String _generateQRData() {
    final data = {
      'client': clientName,
      'date': purchaseDate.toIso8601String(),
      'products': products,
    };
    print(data);
    return jsonEncode(data);
  }
  @override
  Widget build(BuildContext context) {
    //final qrData = _generateQRData();
    //print(qrData);
      final ScreenshotController screenshotController = ScreenshotController();
    return Container(
      width: 300,
      height: 400,
      color: Colors.white,
      child:Screenshot(
         controller: screenshotController,
         child: PrettyQrView.data(
        data: _generateQRData(),
        decoration: const PrettyQrDecoration(
          shape: PrettyQrSmoothSymbol(color: Colors.black)
            ),
        errorCorrectLevel: QrErrorCorrectLevel.Q,
      ),)
      
    );
  }
}

class QRCodeDecryption extends StatefulWidget {
  final void Function(String data)? onScan;

  const QRCodeDecryption({Key? key, this.onScan}) : super(key: key);

  @override
  State<QRCodeDecryption> createState() => _QRCodeDecryptionState();
}

class _QRCodeDecryptionState extends State<QRCodeDecryption> {
  bool _scanned = false;
  bool _hasPermission = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    print('Demande de permission de caméra');
    var status = await Permission.camera.request();
    setState(() {
      _hasPermission = status.isGranted;
      _isLoading = false;
    });
    if (status.isDenied || status.isPermanentlyDenied) {
      print('Permission de caméra refusée');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Permission de caméra requise pour scanner.'),
          action: SnackBarAction(
            label: 'Paramètres',
            onPressed: () => openAppSettings(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Rendu de QRCodeDecryption');
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!_hasPermission) {
      return const Center(
        child: Text(
          'Permission de caméra refusée.\nVeuillez l\'activer dans les paramètres.',
          textAlign: TextAlign.center,
        ),
      );
    }
    return SizedBox.expand(
      child: Stack(
        children: [
          MobileScanner(
            onDetect: (capture) {
              if (_scanned) return;
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                final scannedData = barcodes.first.rawValue!;
                print('QR Code scanné : $scannedData');
                setState(() {
                  _scanned = true;
                });
                widget.onScan?.call(scannedData);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Scanné : $scannedData')),
                );
                Future.delayed(const Duration(seconds: 2), () {
                  setState(() {
                    _scanned = false;
                    print('Réinitialisation de _scanned');
                  });
                });
              }
            },
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Scannez un QR code',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}