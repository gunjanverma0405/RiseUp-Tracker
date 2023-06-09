import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:riseuptracker/database/db_connects.dart';
//import 'package:riseuptracker/dbHelper/contant.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(dbURl);
    await db.open();
    inspect(db);
    userCollection = db.collection(collectAttendee);
  }
}