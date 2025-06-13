import 'dart:io';

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
  bool isFound = false;

  @override
  void initState() {
    super.initState();
    //_filtered = widget.searchList;
  }

  void _onSearchChanged(String value) {
    setState(() {
      if (value.length < 3) {
        _filtered = [];
        isFound = false; // Réinitialiser si moins de 3 caractères
      } else {
        _filtered = widget.searchList
            .where((item) => item.toLowerCase().contains(value.toLowerCase()))
            .toList();
            // Vérifie si un résultat exact est trouvé
        isFound = _filtered.any((item) => item.toLowerCase() == value.toLowerCase());
        if (isFound) {
          _filtered = []; // Masque la liste si un résultat exact est trouvé
        }
      }
    });
    if (widget.onSearch != null) {
      widget.onSearch!(_filtered);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget searchSection = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SearchBar(
          controller: _controller,
          onChanged: _onSearchChanged,
        ),
        if (_filtered.isNotEmpty && !isFound)
          Container(
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            margin: const EdgeInsets.only(top: 4),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filtered.length,
              itemBuilder: (context, index) {
                final item = _filtered[index];
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    _controller.text = item;
                    setState(() {
                      _filtered = []; // Masquer la liste après sélection
                      isFound=false;
                    });
                    _onSearchChanged(item);
                    FocusScope.of(context).unfocus();
                  },
                );
              },
            ),
          ),
      ],
    );

    Widget content;
    if (!widget.isUserConnected) {
      // Non connecté : seulement la barre de recherche + résultats
      content = Padding(
        padding: const EdgeInsets.all(12),
        child: searchSection,
      );
    } else {
      // Connecté : titre, avatar, cloche, barre de recherche + résultats
      content = Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                  padding:const EdgeInsets.only(left: 50),
                  child:Text(
                    widget.userName ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                      )  ),
                if (widget.userImageUrl != null)
                  CircleAvatar(
                    backgroundImage: widget.userImageUrl!.startsWith('http')
                        ? NetworkImage(widget.userImageUrl!)
                        : FileImage(File(widget.userImageUrl!),scale: 20.0) as ImageProvider,
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
            searchSection,
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