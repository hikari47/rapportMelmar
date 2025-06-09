import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductInfo extends StatefulWidget {
  final String id;

  const ProductInfo({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  DocumentSnapshot? product;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.id)
          .get();
      if (mounted) {
        setState(() {
          product = doc;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (error != null) {
      return Center(child: Text('Erreur: $error'));
    }
    if (product == null || !product!.exists) {
      return const Center(child: Text('Produit non trouvé'));
    }
    final data = product!.data() as Map<String, dynamic>;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Text('Nom: ${data['name'] ?? ''}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Description: ${data['description'] ?? ''}'),
                const SizedBox(height: 8),
                Text('Prix: ${data['price']?.toString() ?? ''}'),
                // Ajoute d'autres champs selon ta structure Firestore
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Action pour Book
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Réservation effectuée')),
                  );
                },
                child: const Text('Book'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showPayForm = !_showPayForm;
                  });
                },
                child: const Text('Pay'),
              ),
            ],
          ),
          if (_showPayForm) const PayForm(),
        ],
      ),
    );
  }
}

bool _showPayForm = false;

class PayForm extends StatefulWidget {
  const PayForm({Key? key}) : super(key: key);

  @override
  State<PayForm> createState() => _PayFormState();
}

class _PayFormState extends State<PayForm> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String card = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nom'),
              validator: (v) => v == null || v.isEmpty ? 'Champ requis' : null,
              onSaved: (v) => name = v ?? '',
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Numéro de carte'),
              validator: (v) => v == null || v.isEmpty ? 'Champ requis' : null,
              onSaved: (v) => card = v ?? '',
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Paiement envoyé')),
                  );
                }
              },
              child: const Text('Envoyer'),
            ),
          ],
        ),
      ),
    );
  }
}
