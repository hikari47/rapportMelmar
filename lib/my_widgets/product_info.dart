import 'dart:io';
import'package:flutter/material.dart';


// Interface pour afficher les détails du produit
class ProductInfo extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductInfo({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Affiche toutes les caractéristiques du produit
    return Scaffold(
      appBar: AppBar(
        title: Text(product['title'] ?? 'Produit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            if (product['imageUrl'] != null)
              Center(
                child: product['imageUrl'].toString().startsWith('http')
                    ? Image.network(product['imageUrl'], width: 200, height: 200)
                    : product['imageUrl'].toString().startsWith('/')
                        ? Image.file(File(product['imageUrl']), width: 200, height: 200)
                        : Image.asset(product['imageUrl'], width: 200, height: 200),
              ),
            const SizedBox(height: 16),
            Text(
              product['title'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 8),
            Text(
              product['price'] != null ? '${product['price']} FCFA' : '',
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 16),
            ...product.entries
                .where((e) => e.key != 'imageUrl' && e.key != 'title' && e.key != 'price')
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text('${e.key}: ${e.value}'),
                    )),
          ],
        ),
      ),
    );
  }
}
