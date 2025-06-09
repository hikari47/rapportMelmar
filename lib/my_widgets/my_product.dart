import 'package:flutter/material.dart';
import 'dart:io';
import 'package:appmelmar/my_widgets/product_info.dart';

// Widget principal pour afficher la liste des produits
class MyProduct extends StatelessWidget {
  final Axis direction;
  final List<Map<String, dynamic>> products;

  const MyProduct({
    Key? key,
    required this.direction,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> productWidgets = products.map((product) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ProductInfo(product: product),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          width: 140,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: product['imageUrl'].toString().startsWith('http')
                    ? Image.network(
                        product['imageUrl'],
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      )
                    : product['imageUrl'].toString().startsWith('/')
                        ? Image.file(
                            File(product['imageUrl']),
                            width: 140,
                            height: 140,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            product['imageUrl'],
                            width: 140,
                            height: 140,
                            fit: BoxFit.cover,
                          ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product['title'] ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product['price'] != null ? '${product['price']} FCFA' : '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();

    return direction == Axis.vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: productWidgets,
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: productWidgets,
          );
  }
}

