/*import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
        actions: <Widget>[],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImageView(
              data: qrData,
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
                onPressed: () async {
                  if (qrdataFeed.text.isEmpty) {
                    setState(() {
                      qrData = "";
                    });
                  } else {
                    setState(() {
                      qrData = qrdataFeed.text;
                    });
                  }
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
}

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;

class GenerateQRcode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GenerateQRcodeState();
}

class GenerateQRcodeState extends State<GenerateQRcode> {
  TextEditingController qrdataFeed = TextEditingController();
  String qrData = "";
  final String dbURL = 'mongodb://localhost:27017/mydatabase';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
        actions: <Widget>[],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImageView(
              data: qrData,
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
                onPressed: () async {
                  if (qrdataFeed.text.isEmpty) {
                    setState(() {
                      qrData = "";
                    });
                  } else {
                    setState(() {
                      qrData = qrdataFeed.text;
                    });

                    // Generate the QR code image
                    final qrImage = await QrPainter(
                      data: qrData,
                      version: QrVersions.auto,
                      gapless: false,
                      color: Colors.black,
                      emptyColor: Colors.white,
                    ).toImage(200); // Adjust the size as needed

                    // Convert the image to bytes
                    final qrBytes = await qrImage.toByteData(format: ImageByteFormat.png);
                    final qrImageData = qrBytes!.buffer.asUint8List();

                    // Save the image in MongoDB
                    final db = mongo_dart.Db(dbURL);
                    await db.open();

                    // Create a new GridFS file
                    final file = mongo_dart.GridFSFile();
                    file.filename = 'qr_code.png';
                    file.contentType = 'image/png';
                    file.uploadDate = DateTime.now();
                    file.metadata = {'qrData': qrData};

                    // Write the image bytes to the file
                    final gridFS = db.gridFS;
                    await gridFS.writeFileFromBytes(file, qrImageData);

                    // Close the database connection
                    await db.close();
                  }
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
}*/
