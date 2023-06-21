import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper.internal();
  factory DatabaseHelper() => instance;

  static Database? databasee;

  String tableName = "telefon_tablo";
  String columnName = "name";
  String columnRam = "ram";
  String columnBatarya = "batarya";
  String columnKapasite = "kapasite";
  String columnSistem = "sistem";
  String columnEkran = "ekran";
  String columnKamera = "kamera";

  String tableNamePC = "pc_tablo";
  String columnNamePC = "pc_name";
  String columnDonanimPC = "pc_donanim";
  String columnEkranPC = "pc_ekran";
  String columnSistemPC = "pc_sistem";
  String columnDepolamaPC = "pc_depolama";
  String columnRamPC = "pc_ram";

  DatabaseHelper.internal();

  Future<Database> get database async {
    if (databasee != null) {
      return databasee!;
    }

    databasee = await initDatabase();
    return databasee!;
  }

  Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();

    String path = join(databasePath, 'cihazlar.db');
    ByteData data = await rootBundle.load('assets/cihazlar.db');
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes, flush: true);
    return openDatabase(path, version: 1);
  }

  Future<List<Map<String, dynamic>>> getPhones() async {
    final db = await database;
    final results = await db.query(tableName);
    print('Telefon verileri: $results');
    return results;
  }

  Future<List<Map<String, dynamic>>> getPC() async {
    final db = await database;
    return await db.query(tableNamePC);
  }
}
