import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VideoGalleryVlcPlayer1 extends StatefulWidget {
  const VideoGalleryVlcPlayer1({Key? key}) : super(key: key);

  @override
  State<VideoGalleryVlcPlayer1> createState() => _VideoGalleryVlcPlayer1State();
}

class _VideoGalleryVlcPlayer1State extends State<VideoGalleryVlcPlayer1> {
  VlcPlayerController? _vlcController;
  String? _videoPath;
  double _position = 0;
  double _duration = 1;
  bool _isFullScreen = false;

  @override
  void dispose() {
    _vlcController?.removeListener(_onVlcPlayerChanged);
    _vlcController?.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null && result.files.single.path != null) {
      // Nettoyage de l'ancien contrôleur
      _vlcController?.removeListener(_onVlcPlayerChanged);
      await _vlcController?.dispose();

      final path = result.files.single.path!;
      final controller = VlcPlayerController.file(
        File(path),
        autoPlay: true,
        hwAcc: HwAcc.full,
      );

      controller.addListener(_onVlcPlayerChanged);

      setState(() {
        _videoPath = path;
        _vlcController = controller;
      });
    }
  }

  void _onVlcPlayerChanged() async {
    if (!mounted || _vlcController == null) return;

    try {
      final pos = await _vlcController!.getPosition();
      final dur = await _vlcController!.getDuration();

      if (!mounted) return;

      setState(() {
        _position = pos?.inMilliseconds.toDouble() ?? 0;
        _duration = (dur != null && dur.inMilliseconds > 0)
            ? dur.inMilliseconds.toDouble()
            : 1;
      });
    } catch (e) {
      debugPrint("Erreur dans _onVlcPlayerChanged: $e");
    }
  }

  void _onSeek(double value) {
    if (_vlcController != null && _vlcController!.value.isInitialized) {
      _vlcController!.setTime(value.toInt());
    }
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });

    if (_isFullScreen) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: Colors.black,
            body: GestureDetector(
              onTap: _toggleFullScreen,
              child: SafeArea(
                child: Center(
                  child: _buildVideoPlayer(fullscreen: true),
                ),
              ),
            ),
          ),
        ),
      ).then((_) {
        if (!mounted) return;
        setState(() {
          _isFullScreen = false;
        });
      });
    }
  }

  Widget _buildVideoPlayer({bool fullscreen = false}) {
    if (_vlcController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return GestureDetector(
      onTap: _toggleFullScreen,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: fullscreen ? double.infinity : constraints.maxWidth,
            height:
                fullscreen ? double.infinity : constraints.maxWidth * 9 / 16,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                VlcPlayer(
                  controller: _vlcController!,
                  aspectRatio: fullscreen
                      ? MediaQuery.of(context).size.aspectRatio
                      : (constraints.maxWidth / (constraints.maxWidth * 9 / 16)),
                 // placeholder: const Center(child: CircularProgressIndicator()),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Slider(
                    value: _position.clamp(0, _duration),
                    min: 0,
                    max: _duration,
                    onChanged: _onSeek,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lire une vidéo de la galerie')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickVideo,
              child: const Text('Ouvrir la galerie vidéo'),
            ),
            const SizedBox(height: 20),
            if (_videoPath != null && _vlcController != null)
              Expanded(child: _buildVideoPlayer()),
          ],
        ),
      ),
    );
  }
}
