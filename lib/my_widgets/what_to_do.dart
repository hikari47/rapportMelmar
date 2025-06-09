import 'package:flutter/material.dart';
import 'dart:io';

class WhatToDos extends StatelessWidget {
  final Axis direction;
  final List<Map<String, dynamic>> whatToDoList;

  const WhatToDos({
    Key? key,
    required this.direction,
    required this.whatToDoList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = whatToDoList.map((data) {
      return WhatToDo(
        title: data['title'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
        rating: (data['rating'] ?? 0).toDouble(),
        onTap: data['onTap'],
      );
    }).toList();

    return direction == Axis.vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: widgets,
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: widgets,
          );
  }
}

class WhatToDo extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double rating;
  final VoidCallback? onTap;

  const WhatToDo({
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
      imageWidget = Image.network(
        imageUrl,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      );
    } else if (imageUrl.startsWith('/')) {
      imageWidget = Image.file(
        File(imageUrl),
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      );
    } else {
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

// Exemple d'utilisation du widget WhatToDos
class WhatToDosExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WhatToDos(
      direction: Axis.vertical,
      whatToDoList: [
        {
          'title': 'Visiter le musée',
          'imageUrl': 'https://via.placeholder.com/120',
          'rating': 4.0,
          'onTap': () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Musée sélectionné !')),
            );
          },
        },
        {
          'title': 'Aller au parc',
          'imageUrl': 'assets/images/park.png',
          'rating': 3.5,
          'onTap': () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Parc sélectionné !')),
            );
          },
        },
        {
          'title': 'Randonnée',
          'imageUrl': '/storage/emulated/0/Download/hiking.jpg',
          'rating': 5.0,
          'onTap': () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Randonnée sélectionnée !')),
            );
          },
        },
      ],
    );
  }
}