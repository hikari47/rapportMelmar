import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  final bool isUserConnected;
  final String? userName;
  final String? userImageUrl;
  final VoidCallback? onNotificationTap;
  final List<String> searchList;
  final void Function(List<String>)? onSearch;
  final String? backgroundImage; // <-- Ajout du paramètre

  const TopBar({
    Key? key,
    required this.isUserConnected,
    this.userName,
    this.userImageUrl,
    this.onNotificationTap,
    required this.searchList,
    this.onSearch,
    this.backgroundImage, // <-- Ajout du paramètre
  }) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final TextEditingController _controller = TextEditingController();
  List<String> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = widget.searchList;
  }

  void _onSearchChanged(String value) {
    setState(() {
      _filtered = widget.searchList
          .where((item) => item.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
    if (widget.onSearch != null) {
      widget.onSearch!(_filtered);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (!widget.isUserConnected) {
      // Non connecté : seulement la barre de recherche
      content = Padding(
        padding: const EdgeInsets.all(12),
        child: _SearchBar(
          controller: _controller,
          onChanged: _onSearchChanged,
        ),
      );
    } else {
      // Connecté : titre, avatar, cloche, barre de recherche
      content = Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.userName ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (widget.userImageUrl != null)
                  CircleAvatar(
                    backgroundImage: widget.userImageUrl!.startsWith('http')
                        ? NetworkImage(widget.userImageUrl!)
                        : AssetImage(widget.userImageUrl!) as ImageProvider,
                    radius: 22,
                  ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: widget.onNotificationTap,
                ),
              ],
            ),
            const SizedBox(height: 10),
            _SearchBar(
              controller: _controller,
              onChanged: _onSearchChanged,
            ),
          ],
        ),
      );
    }

    if (widget.backgroundImage == null) {
      return content;
    }

    // Affiche le fond avec Stack
    return Stack(
      children: [
        Positioned.fill(
          child: widget.backgroundImage!.startsWith('http')
              ? Image.network(
                  widget.backgroundImage!,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  widget.backgroundImage!,
                  fit: BoxFit.cover,
                ),
        ),
        Container(
          color: Colors.black.withOpacity(0.2), // Optionnel: filtre sombre
        ),
        content,
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchBar({
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Rechercher...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.send),
          onPressed: () => onChanged(controller.text),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      ),
    );
  }
}