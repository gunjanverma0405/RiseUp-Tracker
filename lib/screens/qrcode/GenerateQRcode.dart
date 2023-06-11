import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class GeneratePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GeneratePageState();
}

class GeneratePageState extends State<GeneratePage> {
  TextEditingController qrdataFeed = TextEditingController();
  String qrData = "";

  Future<void> _shareQRCode() async {
    try {
      final qrCode = await QrPainter(data: qrData, version: QrVersions.auto)
          .toImageData(200);
      final tempDir = await getTemporaryDirectory();
      final tempPath = '${tempDir.path}/qrcode.jpg';

      // Convert the QR code image to JPEG format
      final jpegImage = await decodeImageFromList(qrCode!.buffer.asUint8List());
      final jpegData = await jpegImage.toByteData(format: ImageByteFormat.png);
      final jpegBytes = jpegData!.buffer.asUint8List();

      final file = File(tempPath);
      await file.writeAsBytes(jpegBytes);

      final xfile = XFile(tempPath);
      await Share.shareXFiles([xfile], text: qrData);
    } catch (e) {
      print('Error sharing QR code: $e');
    }
  }

  Future<void> _saveQRCodeToGallery() async {
    try {
      final image = await QrPainter(data: qrData, version: QrVersions.auto)
          .toImageData(200);
      final bytes = image!.buffer.asUint8List();
      final result = await ImageGallerySaver.saveImage(bytes);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('QR code saved to gallery')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save QR code')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareQRCode,
          ),
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: _saveQRCodeToGallery,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 300,
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              const Text(
                "New QR Link Generator",
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                controller: qrdataFeed,
                decoration: InputDecoration(
                  hintText: "Input your link or data",
                ),
                // onChanged: (text) {
                //   setState(() {
                //     qrData = text;
                //   });
                // },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                child: TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.all(15.0),
                    ),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.blue, width: 3.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      qrData = qrdataFeed.text;
                    });
                  },
                  child: const Text(
                    "Generate QR",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
