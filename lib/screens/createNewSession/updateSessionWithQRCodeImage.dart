import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;

import '../../database/db_connects.dart';

Future<void> updateSessionWithQRCodeImage(String sessionId, Uint8List qrCodeImage) async {
  final db = await mongo_dart.Db.create(dbURl);
  await db.open();

  final sessionsCollection = db.collection('Sessions');
  await sessionsCollection.updateOne(
    mongo_dart.where.eq('_id', sessionId),
    mongo_dart.modify.set('qrCodeImage', qrCodeImage),
  );

  await db.close();
}