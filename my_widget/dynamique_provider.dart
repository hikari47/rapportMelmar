import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class DynamiqueProvider<T> with ChangeNotifier {
  List<T> _items = [];
  T? _selectedItem;

  List<T> get items => _items;
  T? get selectedItem => _selectedItem;

  void addItem(T item) {
    _items.add(item);
    notifyListeners();
  }

  void setSelectedItem(T item) {
    _selectedItem = item;
    notifyListeners();
  }

  void removeItem(bool Function(T) test) {
    _items.removeWhere(test);
    notifyListeners();
  }

  void clearSelectedItem() {
    _selectedItem = null;
    notifyListeners();
  }

  void updateItem(T newItem, bool Function(T) test) {
    for (int i = 0; i < _items.length; i++) {
      if (test(_items[i])) {
        _items[i] = newItem;
        notifyListeners();
        break;
      }
    }
    if (_selectedItem != null && test(_selectedItem!)) {
      _selectedItem = newItem;
      notifyListeners();
    }
  }
}

class Video {
  final String title;
  final String path;

  Video({required this.title, required this.path});
}

class ProductService {
  final String name;
  final double price;
  final int quantity;

  ProductService({required this.name, required this.price, required this.quantity});
}

class MyVideos extends StatelessWidget {
  final List<Video> videos;

  const MyVideos({Key? key, required this.videos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.video_library),
            title: Text(video.title),
            subtitle: Text(video.path),
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => VideoPlayerDialog(video: video),
              );
            },
          ),
        );
      },
    );
  }
}

class VideoPlayerDialog extends StatelessWidget {
  final Video video;

  const VideoPlayerDialog({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(video.title),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            // Remplacez ceci par votre widget de lecteur vidéo
            Container(
              height: 200,
              color: Colors.black,
              child: const Center(
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 64,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(video.path),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Fermer'),
        ),
      ],
    );
  }
}

class DynamicListWidget extends StatelessWidget {
  final List<dynamic> items;

  const DynamicListWidget({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        if (item is Video) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.video_library),
              title: Text(item.title),
              subtitle: Text(item.path),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => VideoPlayerDialog(video: item),
                );
              },
            ),
          );
        } else if (item is ProductService) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: Text(item.name),
              subtitle: Text('Prix: ${item.price} x${item.quantity}'),
            ),
          );
        } else if (item is String) {
          return ListTile(
            leading: const Icon(Icons.text_fields),
            title: Text(item),
          );
        } else {
          return ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Type non supporté'),
            subtitle: Text(item.runtimeType.toString()),
          );
        }
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Provider Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dynamic Provider Demo'),
        ),
        body: Center(
          child: Text('Utilisez le fournisseur dynamique ici.'),
        ),
      ),
    );
  }
}


