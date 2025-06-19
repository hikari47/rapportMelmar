import 'dart:io';
import 'dart:typed_data';
import 'package:appmelmar/models/model_produit_service.dart';
import 'package:appmelmar/screens/my_constants_k_widgets/btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
// Ajouts pour QR code et permissions
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_media_store/flutter_media_store.dart';

// Interface pour afficher les détails du produit
class ProductInfo extends StatefulWidget{
 final ModelProduitServiceModel product;
  const ProductInfo({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductInfo> createState() {
    return _ProductInfoState();
  }
} 

class _ProductInfoState extends State<ProductInfo> {
  bool isBuying = false;
  bool isBooking = false;
  bool tapDay = false;
  late DateTime _focusedDay;
  late DateTime myDate;
  DateTime? _selectedDay;
  String? _selectedHour; // Ajout pour stocker l'heure choisie
  List<DateTime> reservedDays = []; // Liste des jours déjà réservés
  List<String> reservedHours = []; // Heures déjà réservées pour le jour sélectionné
  List<String> allHours = [
    '08:00', '09:00', '10:00', '11:00', '12:00',
    '13:00', '14:00', '15:00', '16:00', '17:00'
  ]; // À adapter selon vos besoins
  static const platform = MethodChannel('com.example.app/mediastore');
  // QR code
  String _qrData = '';
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    myDate = DateTime.now();
    // TODO: Charger les jours réservés depuis la base pour ce produit
    // reservedDays = await getReservedDays(widget.product.idModel);
  }

  // Simule la récupération des heures réservées pour un jour donné
  Future<void> fetchReservedHours(DateTime day) async {
    // TODO: Remplacer par un appel réel à la base de données
    // reservedHours = await getReservedHours(widget.product.idModel, day);
    setState(() {
      reservedHours = ['10:00', '14:00']; // Ex: heures déjà prises ce jour-là
    });
  }

  void appuyerBooker() {
    setState(() {
      isBooking = true;
      isBuying = false;
      print('appuie sur booker');
    });
  }

  void appuyerBuyer() {
    setState(() {
      isBooking = false;
      isBuying = true;
      print('appuie sur buyer');
    });
  }

  // Génère la donnée du QR code à partir des infos produit
  void _generateQrData(DateTime dateTimeWithHour) {
    setState(() {
      _qrData =
          'Produit: ${widget.product.nomModel}\nPrix: ${widget.product.prix} FCFA\nDate réservation: $dateTimeWithHour';
    });
  }

  // Capture et sauvegarde le QR code dans la galerie
  Future<void> _captureAndSaveQrCode() async {
    if (_qrData.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Générez un QR code avant de capturer.')),
      );
      return;
    }
    try {
      final Uint8List? image = await _screenshotController.capture();
      if (image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Échec de la capture d\'écran')),
        );
        return;
      }
      // Demande la permission photos/stockage
      var photosStatus = await Permission.photos.request();
      var storageStatus = await Permission.storage.request();
      if (!photosStatus.isGranted && !storageStatus.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Permission requise pour enregistrer dans la galerie.'),
            action: SnackBarAction(
              label: 'Paramètres',
              onPressed: () => openAppSettings(),
            ),
          ),
        );
        return;
      }
      // Utilisation de flutter_media_store pour enregistrer dans la galerie
      final flutterMediaStorePlugin = FlutterMediaStore();
      await flutterMediaStorePlugin.saveFile(
        fileData: image,
        mimeType: 'image/png',
        fileName: 'qrcode_${DateTime.now().millisecondsSinceEpoch}.png',
        rootFolderName: 'DCIM', // DCIM ou Pictures pour la galerie
        folderName: 'QR Codes',
        onSuccess: (String uri, String filePath)async {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('QR Code enregistré dans la galerie')),
          );
          final String? imageUri = await platform.invokeMethod('saveAndOpenImage', {
        'imageData': image,
        'fileName': 'photo_${DateFormat('yyyyMMdd_HHmmss').format(myDate)}.jpg',
        'mimeType': 'image/jpeg',
        'rootFolderName': 'Pictures',
        'folderName': 'MyAppPhotos',
        'dateTime': myDate.millisecondsSinceEpoch,
      });
        },
        onError: (String errorMessage) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Échec de l\'enregistrement : $errorMessage')),
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Affiche toutes les caractéristiques du produit
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.nomModel ?? 'Produit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
            if (widget.product.imagePath != null)
              Center(
                child:widget.product.imagePath.toString().startsWith('http')
                    ? Image.network(
                      widget.product.imagePath,
                       width: 200, height: 200,
                       errorBuilder: (context, error, stackTrace) => Center(
                            child: Icon(Icons.broken_image, size: 60, color: Colors.red),
                          ),)
                    : widget.product.imagePath.toString().startsWith('/')
                        ? Image.file(
                          File(widget.product.imagePath),
                           width: 200, height: 200,
                           errorBuilder: (context, error, stackTrace) => Center(
                            child: Icon(Icons.broken_image, size: 60, color: Colors.red),
                          ),)
                        : Image.asset(
                          widget.product.imagePath,
                           width: 200, height: 200,
                           errorBuilder: (context, error, stackTrace) => Center(
                            child: Icon(Icons.broken_image, size: 60, color: Colors.red),
                          ),)
              ),
            const SizedBox(height: 16),
            Text(
              widget.product.nomModel ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 8),
            Text(
             widget.product.prix != null ? '${widget.product.prix} FCFA' : '',
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 16),
             Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text('${widget.product.nomModel}: ${widget.product.prix}'),
                    ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
             
              children: [
                Expanded( child:InkWell(
                  onTap: (){
                     print('appuie sur booker 0');
                    appuyerBooker();
                    
                  },
                  child:Padding(
                  padding: EdgeInsets.all(2),
                  child: Btn(text: 'Book now', route: '/'),)),
                ),
               Expanded( child:InkWell(
                  onTap: (){
                     print('appuie sur buyer 0');
                    appuyerBuyer();
                    
                  },
                  child:Padding(
                  padding: EdgeInsets.all(2),
                  child: Btn(text: 'Buy', route: '/'),)),
                ),]),
            const SizedBox(height: 16),
               if(isBuying && !isBooking)     
                ...[
                        const TextField(decoration: InputDecoration(
                          label: Text('article'))
                        ),
                        const TextField(decoration: InputDecoration(
                          label: Text('prix'))
                        ),
                        TextField(decoration: InputDecoration(
                          label: Text('moyens de payement'))
                        ),
                        SizedBox(height: 5,),
                        Btn(text: 'Validation', route: '/')
                  ]
                    
                else
                SizedBox(height: 5,),

               if(!isBuying && isBooking)
                ...[
                  TableCalendar(
                    focusedDay: _focusedDay,
                     firstDay: DateTime(_focusedDay.year,_focusedDay.month,1),
                      lastDay: DateTime(_focusedDay.year,_focusedDay.month + 1,0),
                      selectedDayPredicate: (day) => _selectedDay != null && isSameDay(day, _selectedDay),
                      calendarStyle: CalendarStyle(
                             todayDecoration: BoxDecoration(
                             color: Colors.blue,
                             shape: BoxShape.circle,
                              ),
                             selectedDecoration: BoxDecoration(
                             color: Colors.orange,
                             shape: BoxShape.circle,
                              ),
                          ),
                       onDaySelected: (selectedDay, focusedDay) async {
                       setState(() {
                       print('le jour selectionné :$selectedDay');
                       _selectedDay = selectedDay;
                       _focusedDay = focusedDay;

                        });
                        await fetchReservedHours(selectedDay);
                      },
                      calendarBuilders: CalendarBuilders(
                      
                        defaultBuilder: (context, day, focusedDay) {
                          // Si le jour est réservé, couleur rouge
                          bool isReserved = reservedDays.any((d) => isSameDay(d, day));
                          if (isReserved) {
                            return Container(
                              margin: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                               ),
                              alignment: Alignment.center,
                            child: Text(
                              '${day.day}',
                               style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                             );
                          }
                          return null;
                        },
                        selectedBuilder: (context, day, focusedDay)
                        {
                          return Container(
                          margin: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                               ),
                          alignment: Alignment.center,
                        child: Text(
                          '${day.day}',
                           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                         );
                        },

                      ),
                    
                      ),

                    const SizedBox(height: 10),
                    if (_selectedDay != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Choisissez une heure disponible :', style: TextStyle(fontWeight: FontWeight.bold)),
                          Wrap(
                            spacing: 8,
                            children: allHours.map((hour) {
                              bool isTaken = reservedHours.contains(hour);
                              return ChoiceChip(
                                label: Text(hour),
                                selected: _selectedHour == hour,
                                onSelected: isTaken
                                    ? null
                                    : (selected) {
                                        setState(() {
                                          _selectedHour = selected ? hour : null;
                                        });
                                      },
                                backgroundColor: isTaken
                                    ? Colors.red
                                    : (_selectedHour == hour ? Colors.orange : Colors.green),
                                labelStyle: const TextStyle(color: Colors.white),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        if (_selectedDay != null && _selectedHour != null) {
                          final parts = _selectedHour!.split(':');
                          final DateTime dateTimeWithHour = DateTime(
                            _selectedDay!.year,
                            _selectedDay!.month,
                            _selectedDay!.day,
                            int.parse(parts[0]),
                            int.parse(parts[1]),
                          );
                          setState(() {
                            myDate=dateTimeWithHour;
                          });
                          print('Date et heure sélectionnées : $dateTimeWithHour');
                          _generateQrData(dateTimeWithHour);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('QR Code généré, cliquez sur "Generate QRCode" pour enregistrer.')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Veuillez sélectionner un jour et une heure')),
                          );
                        }
                      },
                      child: Btn(
                        text: 'Validation',
                        route: '/',
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (_qrData.isNotEmpty)
                      Column(
                        children: [
                          // Affichage du QR code généré
                          Screenshot(
                            controller: _screenshotController,
                            child: Container(
                              width: 200,
                              height: 200,
                              color: Colors.white,
                              child: PrettyQrView.data(
                                data: _qrData,
                                decoration: const PrettyQrDecoration(
                                  shape: PrettyQrSmoothSymbol(color: Colors.black),
                                ),
                                errorCorrectLevel: QrErrorCorrectLevel.H,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _captureAndSaveQrCode,
                            child: const Text('Generate QRCode'),
                          ),
                        ],
                      ),
                ]
              else
                SizedBox(height: 5,)
                 
              ],
          ),
          
            ),
          ),
        );
      }
}
