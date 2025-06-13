import 'package:flutter/material.dart';

class ProductServiceAchatForm extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final void Function({
    required String paymentMode,
    required String phoneNumber,
    required double total,
    required List<Map<String, dynamic>> products,
  })? onSubmit;

  const ProductServiceAchatForm({
    Key? key,
    required this.products,
    this.onSubmit,
  }) : super(key: key);

  @override
  State<ProductServiceAchatForm> createState() => _ProductServiceAchatFormState();
}

class _ProductServiceAchatFormState extends State<ProductServiceAchatForm> {
  String _paymentMode = 'Orange Money';
  final TextEditingController _phoneController = TextEditingController();

  double get _total {
    return widget.products.fold<double>(
      0,
      (sum, p) => sum + (p['price'] is num ? p['price'].toDouble() : 0.0),
    );
  }

  void _submit() {
    if (_phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez entrer un numéro de téléphone')),
      );
      return;
    }
    if (widget.onSubmit != null) {
      widget.onSubmit!(
        paymentMode: _paymentMode,
        phoneNumber: _phoneController.text.trim(),
        total: _total,
        products: widget.products,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Liste des produits et prix
            ...widget.products.map((p) => ListTile(
                  title: Text(p['title'] ?? ''),
                  trailing: Text('${p['price']} FCFA'),
                )),
            const Divider(),
            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('$_total FCFA', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
           
            // Modes de paiement
            Row(
              children: [
                const Text('Mode de paiement:'),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _paymentMode,
                  items: const [
                    DropdownMenuItem(
                      value: 'Orange Money',
                      child: Text('Orange Money'),
                    ),
                    DropdownMenuItem(
                      value: 'MTN Mobile Money',
                      child: Text('MTN Mobile Money'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _paymentMode = value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Numéro de téléphone
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Numéro de téléphone',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Bouton de validation
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text('Valider l\'achat'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
