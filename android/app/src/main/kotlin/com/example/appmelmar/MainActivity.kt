package com.example.appmelmar

/*import android.content.ContentValues
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel*/

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity()
// {
    /*private val CHANNEL = "com.example.app/mediastore"

    override fun configureFlutterEngine(flutterEngine: FlutterPlugin.FlutterPluginBinding) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "saveAndOpenImage") {
                val imageData = call.argument<ByteArray>("imageData")
                val fileName = call.argument<String>("fileName")
                val mimeType = call.argument<String>("mimeType")
                val rootFolderName = call.argument<String>("rootFolderName")
                val folderName = call.argument<String>("folderName")
                val dateTime = call.argument<Long>("dateTime")

                try {
                    // Sauvegarder l'image dans MediaStore
                    val resolver = contentResolver
                    val collection = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                        MediaStore.Images.Media.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY)
                    } else {
                        MediaStore.Images.Media.EXTERNAL_CONTENT_URI
                    }

                    val values = ContentValues().apply {
                        put(MediaStore.Images.Media.DISPLAY_NAME, fileName)
                        put(MediaStore.Images.Media.MIME_TYPE, mimeType)
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                            put(MediaStore.MediaColumns.RELATIVE_PATH, "$rootFolderName/$folderName")
                            put(MediaStore.MediaColumns.DATE_ADDED, dateTime / 1000)
                            put(MediaStore.MediaColumns.DATE_MODIFIED, dateTime / 1000)
                            put(MediaStore.MediaColumns.IS_PENDING, 1)
                        }
                    }

                    val uri = resolver.insert(collection, values)
                    uri?.let {
                        resolver.openOutputStream(it).use { outputStream ->
                            outputStream?.write(imageData)
                        }
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                            values.clear()
                            values.put(MediaStore.MediaColumns.IS_PENDING, 0)
                            resolver.update(uri, values, null, null)
                        }

                        // Ouvrir la galerie sur l'image
                        val intent = Intent(Intent.ACTION_VIEW).apply {
                            setDataAndType(uri, mimeType)
                            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                        }
                        startActivity(intent)

                        result.success(uri.toString())
                    } ?: result.error("ERROR", "Échec de la création du fichier", null)
                } catch (e: Exception) {
                    result.error("ERROR", e.message, null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}*/
