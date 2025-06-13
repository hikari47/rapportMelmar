import 'package:flutter/material.dart';
import 'new.dart';
// Si vous souhaitez utiliser Firebase, décommentez les lignes suivantes :
 import 'package:cloud_firestore/cloud_firestore.dart';

class StreamNewExample extends StatelessWidget {
  // Simule un flux de news (par exemple depuis Firestore, REST API, etc.)
  final Stream<Map<String, dynamic>> newsStream = Stream.periodic(
    const Duration(seconds: 2),
    (count) => {
      'title': 'News #$count',
      'imageUrl': count % 2 == 0
          ? 'https://via.placeholder.com/120'
          : 'assets/images/news.png',
      'rating': (count % 5) + 1.0,
      'onTap': null,
    },
  ).take(10);

  // Exemple de stream depuis Firebase Firestore (décommentez pour utiliser)
  
  Stream<Map<String, dynamic>> get firebaseNewsStream {
    return FirebaseFirestore.instance
        .collection('news')
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty
            ? snapshot.docs.first.data()
            : {});
  }
  

  @override
  Widget build(BuildContext context) {
    // Pour utiliser Firebase, remplacez "newsStream" par "firebaseNewsStream" ci-dessous.
    return StreamBuilder<Map<String, dynamic>>(
      stream: newsStream, // ou firebaseNewsStream
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return const Center(child: Text('Aucune news disponible'));
        }
        final data = snapshot.data!;
        return Center(
          child: New(
            title: data['title'] ?? '',
            imageUrl: data['imageUrl'] ?? '',
            rating: (data['rating'] ?? 0).toDouble(),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${data['title']} cliquée !')),
              );
            },
          ),
        );
      },
    );
  }
}
