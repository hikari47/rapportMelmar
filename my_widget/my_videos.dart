import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class Video {
  final String title;
  final String path; // Can be a local path or URL

  Video({required this.title, required this.path});
}

class MyVideos extends StatelessWidget {
  final List<Video> videos;

  const MyVideos({Key? key, required this.videos}) : super(key: key);

  void _showVideoDialog(BuildContext context, Video video) {
    showDialog(
      context: context,
      builder: (context) => VideoPlayerDialog(video: video),
    );
  }

  @override
  Widget build(BuildContext context) {
    return videos.isEmpty
        ? const Center(child: Text('No videos available'))
        : ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: const Icon(Icons.play_circle_fill, size: 40),
                  title: Text(video.title),
                  subtitle: Text(video.path),
                  onTap: () => _showVideoDialog(context, video),
                ),
              );
            },
          );
  }
}

class VideoPlayerDialog extends StatefulWidget {
  final Video video;

  const VideoPlayerDialog({Key? key, required this.video}) : super(key: key);

  @override
  _VideoPlayerDialogState createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<VideoPlayerDialog> {
  late VlcPlayerController _vlcController;
  bool _isPlaying = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _vlcController = VlcPlayerController.network(
      widget.video.path,
      autoPlay: true,
      hwAcc: HwAcc.auto, // Use auto to adapt to platform capabilities
      onInit: () {
        setState(() {});
      },
      onError: (error) {
        setState(() {
          _errorMessage = 'Failed to load video: ${error.message}';
        });
      },
    );
  }

  @override
  void dispose() {
    _vlcController.stop();
    _vlcController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_vlcController.value.isPlaying) {
        _vlcController.pause();
        _isPlaying = false;
      } else {
        _vlcController.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Video Player
            Expanded(
              child: _errorMessage != null
                  ? Center(child: Text(_errorMessage!))
                  : VlcPlayer(
                      controller: _vlcController,
                      aspectRatio: 16 / 9,
                      placeholder: const Center(child: CircularProgressIndicator()),
                    ),
            ),
            // Playback Controls
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                    onPressed: _errorMessage == null ? _togglePlayPause : null,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}