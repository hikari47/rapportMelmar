import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_media_store/flutter_media_store.dart';

class DownloadHelper {
  /// Enregistre une image (Uint8List) dans la galerie ou un dossier spécifique.
  static Future<String?> saveImage(Uint8List imageData, String fileName, {String? folderName}) async {
    if (Platform.isAndroid) {
      if (!await Permission.storage.request().isGranted) return null;
      final flutterMediaStorePlugin = FlutterMediaStore();
      String? savedPath;
      await flutterMediaStorePlugin.saveFile(
        fileData: imageData,
        mimeType: 'image/png',
        fileName: fileName,
        rootFolderName: 'Pictures',
        folderName: folderName ?? 'SavedImages',
        onSuccess: (String uri, String filePath) {
          savedPath = filePath;
        },
        onError: (String errorMessage) {
          savedPath = null;
        },
      );
      return savedPath;
    } else {
      // iOS ou fallback
      final dir = await _getDirectory(folderName);
      if (dir == null) return null;
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(imageData);
      return file.path;
    }
  }

  /// Enregistre une vidéo (Uint8List) dans la galerie ou un dossier spécifique.
  static Future<String?> saveVideo(Uint8List videoData, String fileName, {String? folderName}) async {
    if (Platform.isAndroid) {
      if (!await Permission.storage.request().isGranted) return null;
      final flutterMediaStorePlugin = FlutterMediaStore();
      String? savedPath;
      await flutterMediaStorePlugin.saveFile(
        fileData: videoData,
        mimeType: 'video/mp4',
        fileName: fileName,
        rootFolderName: 'Movies',
        folderName: folderName ?? 'SavedVideos',
        onSuccess: (String uri, String filePath) {
          savedPath = filePath;
        },
        onError: (String errorMessage) {
          savedPath = null;
        },
      );
      return savedPath;
    } else {
      // iOS ou fallback
      final dir = await _getDirectory(folderName);
      if (dir == null) return null;
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(videoData);
      return file.path;
    }
  }

  /// Enregistre un texte dans un fichier dans un dossier spécifique.
  static Future<String?> saveText(String text, String fileName, {String? folderName}) async {
    final dir = await _getDirectory(folderName);
    if (dir == null) return null;
    final file = File('${dir.path}/$fileName');
    await file.writeAsString(text);
    return file.path;
  }

  /// Retourne la liste des répertoires visibles par l'utilisateur (Documents, Downloads, Pictures, Movies, Music).
  static Future<List<Directory>> getVisibleDirectories() async {
    List<Directory> dirs = [];
    if (Platform.isAndroid) {
      final downloads = await getExternalStorageDirectory();
      final pictures = Directory('/storage/emulated/0/Pictures');
      final movies = Directory('/storage/emulated/0/Movies');
      final music = Directory('/storage/emulated/0/Music');
      final documents = Directory('/storage/emulated/0/Documents');
      if (downloads != null) dirs.add(downloads);
      dirs.addAll([pictures, movies, music, documents]);
    } else if (Platform.isIOS) {
      final docs = await getApplicationDocumentsDirectory();
      dirs.add(docs);
    }
    return dirs;
  }

  /// Demande la permission de stockage si nécessaire et retourne le dossier cible.
  static Future<Directory?> _getDirectory(String? folderName) async {
    if (await Permission.storage.request().isGranted) {
      Directory baseDir;
      if (Platform.isAndroid) {
        baseDir = (await getExternalStorageDirectory())!;
      } else {
        baseDir = await getApplicationDocumentsDirectory();
      }
      if (folderName != null && folderName.isNotEmpty) {
        final customDir = Directory('${baseDir.path}/$folderName');
        if (!(await customDir.exists())) {
          await customDir.create(recursive: true);
        }
        return customDir;
      }
      return baseDir;
    }
    return null;
  }
}
