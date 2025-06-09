import 'dart:io';

import 'package:flutter/material.dart';

// Widget principal pour afficher une liste d'événements
class Events extends StatelessWidget {
  final Axis direction;
  final List<Map<String, dynamic>> eventsList;

  const Events({
    Key? key,
    required this.direction,
    required this.eventsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> eventWidgets = eventsList.map((data) {
      return Event(
        title: data['title'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
        rating: (data['rating'] ?? 0).toDouble(),
        onTap: data['onTap'],
      );
    }).toList();

    return direction == Axis.vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: eventWidgets,
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: eventWidgets,
          );
  }
}

// Widget pour un événement individuel
class Event extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double rating;
  final VoidCallback? onTap;

  const Event({
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

// Widget pour afficher la notation par étoiles
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

// Exemple d'utilisation du widget Events
class EventsExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Events(
      direction: Axis.vertical,
      eventsList: [
        {
          'title': 'Event Firebase',
          'imageUrl': 'https://via.placeholder.com/120',
          'rating': 4.0,
          'onTap': () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Event Firebase cliqué !')),
            );
          },
        },
        {
          'title': 'Event local',
          'imageUrl': 'assets/images/event.png',
          'rating': 3.5,
          'onTap': () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Event local cliqué !')),
            );
          },
        },
        {
          'title': 'Event téléphone',
          'imageUrl': '/storage/emulated/0/Download/event_image.jpg',
          'rating': 5.0,
          'onTap': () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Event téléphone cliqué !')),
            );
          },
        },
      ],
    );
  }
}