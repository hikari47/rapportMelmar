import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// TopBar alimenté par un Stream
class TopBarStream extends StatelessWidget {
  final Stream<TopBarData> stream;

  const TopBarStream({Key? key, required this.stream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TopBarData>(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final data = snapshot.data!;
        return TopBar(
          imagePath: data.imagePath,
          title: data.title,
          tags: data.tags,
        );
      },
    );
  }
}

class TopBarData {
  final String imagePath;
  final String title;
  final List<String> tags;

  TopBarData({
    required this.imagePath,
    required this.title,
    required this.tags,
  });
}

class TopBar extends StatelessWidget {
  final String imagePath;
  final String title;
  final List<String> tags;

  const TopBar({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextField(
          decoration: InputDecoration(
            hintText: "Rechercher...",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: tags.map((tag) => Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                tag,
                style: const TextStyle(color: Colors.blue),
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }
}

// Widget Event : image cliquable qui ouvre un lien
class Event extends StatelessWidget {
  final String imagePath;
  final String url;

  const Event({
    Key? key,
    required this.imagePath,
    required this.url,
  }) : super(key: key);

  Future<void> _launchUrl() async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchUrl,
      child: Image.asset(
        imagePath,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      ),
    );
  }
}

// Events alimenté par un Stream
class EventsStream extends StatelessWidget {
  final Stream<EventsData> stream;

  const EventsStream({Key? key, required this.stream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EventsData>(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final data = snapshot.data!;
        return Events(
          title: data.title,
          events: data.events,
        );
      },
    );
  }
}

class EventsData {
  final String title;
  final List<Event> events;

  EventsData({
    required this.title,
    required this.events,
  });
}

class Events extends StatelessWidget {
  final String title;
  final List<Event> events;

  const Events({
    Key? key,
    required this.title,
    required this.events,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: events,
          ),
        ),
      ],
    );
  }
}
//events
