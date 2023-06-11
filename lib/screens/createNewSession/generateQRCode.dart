/*import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;
import 'dart:ui';

Uint8List generateQRCode(String sessionId) {
  final qrCode = QrImageView(
    data: sessionId,
    version: QrVersions.auto,
    size: 200.0,
  );

  final qrCodeImage = qrCode.toByteData();
  return Uint8List.view(qrCodeImage.buffer);
}*/