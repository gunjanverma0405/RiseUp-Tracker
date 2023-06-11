import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanPage extends StatefulWidget {
  final String sessionID;
  final VoidCallback onQRScanned;

  QRScanPage({
    required this.sessionID,
    required this.onQRScanned,
  });

  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final GlobalKey _qrKey = GlobalKey();
  QRViewController? _qrViewController;
  String qrData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: _qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
      Expanded(
        flex: 1,
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                'Scanned QR Code: $qrData',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 10), // Adjust the spacing between the text and the button
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: qrData.isNotEmpty
                    ? () {
                  widget.onQRScanned();
                  Navigator.pop(context);
                }
                    : null,
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
  ],
    ),

    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _qrViewController = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrData = scanData.code!;
      });
    });
  }

  @override
  void dispose() {
    _qrViewController?.dispose();
    super.dispose();
  }
}
