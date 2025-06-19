import 'package:appmelmar/models/model_produit_service.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:appmelmar/my_widgets/product_info.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

// Widget principal pour afficher la liste des produits
class MyProduct extends StatelessWidget {
  final Axis direction;
  final double? l;
  final List<ModelProduitServiceModel> products;

  const MyProduct({
    Key? key,
    required this.direction,
    this.l,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> productWidgets = products.map((product) {
      // Détection de l'extension
      String path = product.imagePath ?? '';
      String ext = path.split('.').last.toLowerCase();
      bool isVideo = ['mp4', 'mov', 'avi', 'mkv', 'webm'].contains(ext);

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
          width: l==null?200:l,
          height: 250,
          color: Colors.blue,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: isVideo
                      ? VlcPlayer(
                          controller: VlcPlayerController.file(File(path)),
                          aspectRatio: 16 / 9,
                          placeholder: const Center(child: CircularProgressIndicator()),
                        )
                      : path.startsWith('http')
                          ? Image.network(
                              path,
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) => Center(
                                child: Icon(Icons.broken_image, size: 60, color: Colors.white),
                              ),
                            )
                          : path.startsWith('/')
                              ? Image.file(
                                  File(path),
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) => Center(
                                    child: Icon(Icons.broken_image, size: 60, color: Colors.red),
                                  ),
                                )
                              : Image.asset(
                                  path,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) => Center(
                                    child: Icon(Icons.broken_image, size: 60, color: Colors.white),
                                  ),
                                ),
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
                      product.nomModel ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.prix != null ? '${product.prix} FCFA' : '',
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
        ? SingleChildScrollView( 
          scrollDirection: direction, 
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: productWidgets,
          ),) 
        : SingleChildScrollView( 
          scrollDirection: direction, 
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: productWidgets,
          ),);
  }
}

