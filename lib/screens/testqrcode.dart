import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_media_store/flutter_media_store.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

void main() {
  runApp(const QRCodeApp());
}

class QRCodeApp extends StatelessWidget {
  const QRCodeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QRCodeInterface(),
    );
  }
}

class QRCodeInterface extends StatefulWidget {
  const QRCodeInterface({Key? key}) : super(key: key);

  @override
  State<QRCodeInterface> createState() => _QRCodeInterfaceState();
}

class _QRCodeInterfaceState extends State<QRCodeInterface> {
  final TextEditingController _qrDataController = TextEditingController();
  final ScreenshotController _screenshotController = ScreenshotController();
  String _qrData = '';
  String _scannedData = '';
  bool _hasCameraPermission = false;
  bool _isLoadingPermission = true;

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  Future<void> _checkCameraPermission() async {
    print('Vérification de la permission de caméra');
    var status = await Permission.camera.request();
    setState(() {
      _hasCameraPermission = status.isGranted;
      _isLoadingPermission = false;
    });
    if (!status.isGranted) {
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

  void _generateQRCode() {
    setState(() {
      _qrData = _qrDataController.text.trim();
      print('Génération du QR code avec les données : $_qrData');
    });
  }

  Future<void> _captureScreenshot() async {
  if (_qrData.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Générez un QR code avant de capturer.')),
    );
    return;
  }

  try {
    print('Tentative de capture d\'écran');
    final Uint8List? image = await _screenshotController.capture();
    if (image == null) {
      print('Échec de la capture d\'écran : image null');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Échec de la capture d\'écran')),
      );
      return;
    }

    print('Vérification de la permission de stockage');
    var storageStatus = await Permission.storage.request();
    if (!storageStatus.isGranted) {
      print('Permission de stockage refusée');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Permission de stockage requise pour enregistrer.'),
          action: SnackBarAction(
            label: 'Paramètres',
            onPressed: () => openAppSettings(),
          ),
        ),
      );
      return;
    }

    print('Sauvegarde de l\'image dans la galerie');
    final flutterMediaStorePlugin = FlutterMediaStore();
    await flutterMediaStorePlugin.saveFile(
      fileData: image,
      mimeType: 'image/png',
      fileName: 'qrcode_${DateTime.now().millisecondsSinceEpoch}.png',
      rootFolderName: 'Pictures',
      folderName: 'QR Codes',
      onSuccess: (String uri, String filePath) {
        print('Image enregistrée dans la galerie : $filePath');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('QR Code enregistré dans la galerie')),
        );
      },
      onError: (String errorMessage) {
        print('Échec de l\'enregistrement dans la galerie : $errorMessage');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de l\'enregistrement : $errorMessage')),
        );
      },
    );
  } catch (e) {
    print('Erreur lors de la capture ou de l\'enregistrement : $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erreur : $e')),
    );
  }
}

  void _startQRScan() {
    if (!_hasCameraPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission de caméra refusée.')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRScannerScreen(
          onScan: (data) {
            setState(() {
              _scannedData = data;
              print('Données scannées : $data');
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _qrDataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Générer et Scanner QR Code'),
      ),
      body: _isLoadingPermission
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Générer un QR Code',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _qrDataController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Entrez les données du QR code',
                      hintText: 'Ex. : https://example.com ou texte',
                    ),
                    onSubmitted: (_) => _generateQRCode(),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _generateQRCode,
                    child: const Text('Générer QR Code'),
                  ),
                  const SizedBox(height: 20),
                  if (_qrData.isNotEmpty)
                    Column(
                      children: [
                        Center(
                          child: Screenshot(
                            controller: _screenshotController,
                            child: Container(
                              width: 200,
                              height: 200,
                              color: Colors.white,
                              child: PrettyQrView.data(
                                data: _qrData,
                                decoration: const PrettyQrDecoration(
                                  shape: PrettyQrSmoothSymbol(color: Colors.black),
                                ),
                                errorCorrectLevel: QrErrorCorrectLevel.H,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _captureScreenshot,
                          child: const Text('Capturer QR Code'),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  const Text(
                    'Scanner un QR Code',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _startQRScan,
                    child: const Text('Lancer le Scanner'),
                  ),
                  const SizedBox(height: 20),
                  if (_scannedData.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Résultat du Scan :',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(_scannedData, style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                ],
              ),
            ),
    );
  }
}

class QRScannerScreen extends StatefulWidget {
  final void Function(String data) onScan;

  const QRScannerScreen({Key? key, required this.onScan}) : super(key: key);

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  bool _scanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner QR Code'),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            MobileScanner(
              onDetect: (capture) {
                if (_scanned) return;
                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                  setState(() {
                    _scanned = true;
                  });
                  final scannedData = barcodes.first.rawValue!;
                  widget.onScan(scannedData);
                  Navigator.pop(context);
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
      ),
    );
  }
}