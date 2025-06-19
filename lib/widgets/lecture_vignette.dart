import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VideoSelectorScreen(),
    );
  }
}

class VideoSelectorScreen extends StatefulWidget {
  @override
  _VideoSelectorScreenState createState() => _VideoSelectorScreenState();
}

class _VideoSelectorScreenState extends State<VideoSelectorScreen> {
  List<File> selectedVideos = [];
  List<String> newVideoPaths=[];
  List<String> thumbnails = [];
  List<String> tempThumbnails = [];
 String p="";
 //late dirp;
  // Fonction pour sélectionner plusieurs vidéos (ajout incrémental)
  Future<void> _pickVideos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: true,
    );
    final dirp=await getExternalStorageDirectory();
    if (result != null) {
      List<File> videos = result.paths.map((path) => File(path!)).toList();
      
  print(result.paths);
  setState(() {
    p = result.paths.toString();
  });

      // Générer les vignettes pour chaque vidéo
      for (var video in videos) {
        final thumbnailPath = await VideoThumbnail.thumbnailFile(
          thumbnailPath: dirp!.path,
          video: video.path,
          imageFormat: ImageFormat.PNG,
          quality: 75,
        );
        if (thumbnailPath != null) {
          tempThumbnails.add(thumbnailPath);
          print('Vignette générée pour ${video.path}: $thumbnailPath');
        }

         // Copier la vidéo dans le même dossier que le thumbnail
        final fileName = video.path.split('/').last;
        final newVideoPath = '${dirp.path}/$fileName';
        if (video.path != newVideoPath) {
           await video.copy(newVideoPath);
           newVideoPaths.add(newVideoPath);
           print('Vidéo copiée dans : $newVideoPath');
       }
      }

      setState(() {
        // Ajout incrémental
        selectedVideos.addAll(videos);
        thumbnails.addAll(tempThumbnails);
      });
    }
  }

  // Fonction pour lancer une vidéo dans le lecteur natif
  Future<void> _launchVideo(String path) async {
    //final Uri uri = Uri.parse('file://$path');
    final Uri uri = Uri.file(path);
    print('path: $path');
    print('uri: $uri');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Impossible de lancer la vidéo')),
      );
    }
  }

  @override
  void dispose() {
    // Libérer les ressources des vignettes
    /*for (var thumbnail in thumbnails) {
      File(thumbnail).delete();
    }*/
    super.dispose();
  }

  @override
  void initState(){
   //dirp=await getApplicationDocumentsDirectory();
   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sélecteur de vidéos'),
      ),
      body: Column(
        children: [
          Text(
            'chemin : $p',
            style: TextStyle(fontSize: 16),
          ),
          ElevatedButton(
            onPressed: _pickVideos,
            child: Text('Sélectionner des vidéos'),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: selectedVideos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onDoubleTap: () {
                  //_launchVideo(selectedVideos[index].path);
                   _launchVideo(newVideoPaths[index]);
                  },
                  child: thumbnails.isNotEmpty && index < thumbnails.length
                      ?  Container(
                         width: 300,
                         height: 300,
                         padding: EdgeInsets.all(5.0),
                        child: Stack(
                          children: [
                            ClipRRect( borderRadius: BorderRadius.circular(10.0),
                              child: Image.file(
                              File(thumbnails[index]),
                              fit: BoxFit.fill,
                              width: 250,
                            ),),
                            
                            Positioned(
                              top: 30.0,
                              left: 25.0,
                              child: IconButton(
                                icon: Icon(Icons.play_circle_outline_outlined, color: Color.fromRGBO(255, 255,255, 0.5),size: 80.0,),
                                onPressed: () {
                                  _launchVideo(newVideoPaths[index]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ) 
                      : Container(
                          color: Colors.grey,
                          child: Center(child: Text('Aucune vignette')),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}