import 'package:appmelmar/models/model_produit_service.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// Exemple de modèle de service
class Service {
  final String title;
  final String imageUrl; // Peut être une URL réseau ou un chemin local

  Service({required this.title, required this.imageUrl});
}

// Widget principal
class ServicesGrid extends StatelessWidget {
  final List<ModelProduitServiceModel> services;

  const ServicesGrid({Key? key, required this.services}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Nombre de colonnes
        childAspectRatio: 1,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        Widget imageWidget;
        if (service.imagePath.startsWith('http')) {
          imageWidget = Image.network(service.imagePath, fit: BoxFit.cover);
        } else if (service.imagePath.startsWith('/')) {
          imageWidget = Image.file(File(service.imagePath), fit: BoxFit.cover);
        } else {
          imageWidget = Image.asset(service.imagePath, fit: BoxFit.cover);
        }
        return InkWell(
          onTap: () {
            // Naviguer vers une autre page, à adapter selon votre logique
            Navigator.pushNamed(context, '/${service.nomModel.toLowerCase()}');
          },
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: imageWidget,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(service.nomModel, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        );
      },
    ),
      );
  }
}
