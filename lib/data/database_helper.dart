// ignore_for_file: depend_on_referenced_packages
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    io.Directory applicationDirectory =
        await getApplicationDocumentsDirectory();

    String dbPathAttendance =
        path.join(applicationDirectory.path, 'listaAsistencia.db');

    bool dbExists = await io.File(dbPathAttendance).exists();
    if (!dbExists) {
      ByteData data = await rootBundle
          .load(path.join('assets/database', 'listaAsistenciaDB.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await io.File(dbPathAttendance).writeAsBytes(bytes, flush: true);
    }
    Database database = await openDatabase(dbPathAttendance);

    debugPrint('Se abrio base de datos');

    return database;
  }
}
