import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class GeneratePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GeneratePageState();
}

class GeneratePageState extends State<GeneratePage> {
  TextEditingController qrdataFeed = TextEditingController();
  String qrData = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              if (qrData.isNotEmpty) {
                final image = await _generateQrCodeImage(qrData);
                await Share.shareXFiles(
                  [XFile('qr_code.png')],
                  text: 'QR Code',
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: () async {
              if (qrData.isNotEmpty) {
                final image = await _generateQrCodeImage(qrData);
                final result = await ImageGallerySaver.saveImage(
                  image.buffer.asUint8List(),
                  name: 'qr_code',
                );
                if (result['isSuccess']) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Downloaded'),
                        content: const Text('QR code saved to gallery.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              }
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImageView(
              data: qrData,
              size: 300,
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
              onChanged: (text) {
                setState(() {
                  qrData = text;
                });
              },
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
    );
  }

  Future<Uint8List> _generateQrCodeImage(String data) async {
    final qrCode = QrImageView(
      data: data,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
      size: 200,
    );

    final qrCodeWidget = RepaintBoundary(
      child: qrCode,
    );

    final boundary = qrCodeWidget.createRenderObject(context);
    final image = await boundary.toImage(pixelRatio: 1.0);
    final byteData = await image.toByteData(format: ImageByteFormat.png);

    if (byteData != null) {
      return byteData.buffer.asUint8List();
    }

    return Uint8List(0);
  }
}
