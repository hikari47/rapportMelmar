import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ProductService {
  final String name;
  final double price;
  final int quantity;

  ProductService({
    required this.name,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'quantity': quantity,
      };
}

class QRCodeGeneration extends StatelessWidget {
  final List<ProductService> products;
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
      'products': products.map((p) => p.toJson()).toList(),
    };
    return data.toString();
  }

  @override
  Widget build(BuildContext context) {
    final qrData = _generateQRData();
    return Center(
      child: PrettyQrView.data(
        data: qrData,
        decoration: const PrettyQrDecoration(),
        errorCorrectLevel: QrErrorCorrectLevel.M,
      ),
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

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      onDetect: (capture) {
        if (_scanned) return;
        final List<Barcode> barcodes = capture.barcodes;
        if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
          setState(() {
            _scanned = true;
          });
          widget.onScan?.call(barcodes.first.rawValue!);
          // Optionally, you can show a dialog or navigate here
        }
      },
    );
  }
}
