import 'package:flutter/material.dart';
import 'dart:io';

class News extends StatelessWidget {
  final Axis direction;
  final List<Map<String, dynamic>> newsList;

  const News({
    Key? key,
    required this.direction,
    required this.newsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> newsWidgets = newsList.map((data) {
      return New(
        title: data['title'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
        rating: (data['rating'] ?? 0).toDouble(),
        onTap: data['onTap'],
      );
    }).toList();

    return direction == Axis.vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: newsWidgets,
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: newsWidgets,
          );
  }
}

class New extends StatelessWidget {
  final String title;
  final String imageUrl; // Peut être un lien Firebase Storage ou un chemin local
  final double rating;
  final VoidCallback? onTap;

  const New({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.rating,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (imageUrl.startsWith('http')) {
      // Image depuis Firebase Storage (URL)
      imageWidget = Image.network(
        imageUrl,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      );
    } else if (imageUrl.startsWith('/')) {
      // Image depuis un répertoire du téléphone (chemin absolu)
      imageWidget = Image.file(
        File(imageUrl),
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      );
    } else {
      // Image depuis sqflite (chemin local)
      imageWidget = Image.asset(
        imageUrl,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
        
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageWidget,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            _StarRating(rating: rating),
          ],
        ),
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  final double rating;
  const _StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool halfStar = (rating - fullStars) >= 0.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < fullStars) {
          return const Icon(Icons.star, color: Colors.amber, size: 20);
        } else if (i == fullStars && halfStar) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 20);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 20);
        }
      }),
    );
  }
}

// Exemple d'utilisation du widget New
class NewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: New(
        title: 'Titre de la news',
        imageUrl: 'https://via.placeholder.com/120', // ou un chemin local ex: 'assets/images/news.png'
        rating: 4.5,
        onTap: () {
          // Action lors du clic
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('News cliquée !')),
          );
        },
      ),
    );
  }
}

// Exemple d'utilisation du widget New avec une image locale
class NewLocalImageExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: New(
        title: 'News locale',
        imageUrl: 'assets/images/news.png', // Assurez-vous que ce fichier existe et est déclaré dans pubspec.yaml
        rating: 3.5,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('News locale cliquée !')),
          );
        },
      ),
    );
  }
}

// Exemple d'utilisation du widget New avec une image depuis un répertoire du téléphone
class NewFileImageExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Remplacez ce chemin par un chemin valide sur votre appareil
    final String filePath = '/storage/emulated/0/Download/news_image.jpg';
    return Center(
      child: New(
        title: 'News depuis le téléphone',
        imageUrl: filePath,
        rating: 5.0,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('News depuis le téléphone cliquée !')),
          );
        },
      ),
    );
  }
}