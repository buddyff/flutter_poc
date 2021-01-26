import 'dart:async';
import 'dart:io';

import 'package:flutter_poc/models/medication_list_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

//import 'package:sqflite/sqflite.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DBManager {
  DBManager._();

  static final DBManager db = DBManager._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path,
        version: 2,
        onOpen: (db) {},
        password: 'hello world', onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Medication ("
          "id TEXT PRIMARY KEY,"
          "fullName TEXT"
          ")");
    });
  }

  newMed(Medication newMed) async {
    final db = await database;
    var res = await db.insert("Medication", newMed.toMap());
    return res;
  }

  getAllMeds() async {
    final db = await database;
    var res = await db.query("Medication");
    List<Medication> list =
        res.isNotEmpty ? res.map((c) => Medication.fromMap(c)).toList() : [];
    return list;
  }
}
