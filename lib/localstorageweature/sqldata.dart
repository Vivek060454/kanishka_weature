import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class SQLHe {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE iteme1(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        addrese TEXT,
        latitude DOUBLE,
        longitude DOUBLE,
        utc INT,
        timezone TEXT,
        timeabbr TEXT,
             elevation TEXT,
        currenttemp DOUBLE,
        currentunit TEXT,
   
        waeture0 INT,
        temperatuemax0 DOUBLE,
        temperaturemin0 DOUBLE,
        sunrise0 TEXT,
        sunset0 TEXT,
        
          waeture1 INT,
        temperatuemax1 DOUBLE,
        temperaturemin1 DOUBLE,
        sunrise1 TEXT,
        sunset1 TEXT,
          waeture2 INT,
        temperatuemax2 DOUBLE,
        temperaturemin2 DOUBLE,
        sunrise2 TEXT,
        sunset2 TEXT,
          waeture3 INT,
        temperatuemax3 DOUBLE,
        temperaturemin3 DOUBLE,
        sunrise3 TEXT,
        sunset3 TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbtecuh1.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(
      String addrese,
      double latitude,
      double? longitude,
      int utc,
      String timezone,
      String timeabbr,
      String elevation,
      double currenttemp,
      String currentunit,

      int waeture0,
      double temperaturemax0,
      double? temperaturemin0,
      String sunrise0,
      String sunset0,

      int waeture1,
      double temperaturemax1,
      double? temperaturemin1,
      String sunrise1,
      String sunset1,
      int waeture2,
      double temperaturemax2,
      double? temperaturemin2,
      String sunrise2,
      String sunset2,

      int waeture3,
      double temperaturemax3,
      double? temperaturemin3,
      String sunrise3,
      String sunset3,

     ) async {
    final db = await SQLHe.db();

    final data = {
      'addrese':addrese,
      'latitude': latitude,
      'longitude': longitude,
      'utc': utc,
      'timezone': timezone,
      'timeabbr': timeabbr,
      'currenttemp':currenttemp,
      "currentunit":currentunit,
      'elevation':elevation,
      'waeture0':waeture0,
      'temperatuemax0': temperaturemax0,
      'temperaturemin0': temperaturemin0,
      'sunrise0': sunrise0,
      'sunset0': sunset0,
      'waeture1':waeture1,
      'temperatuemax1': temperaturemax1,
      'temperaturemin1': temperaturemin1,
      'sunrise1': sunrise1,
      'sunset1': sunset1,
      'waeture2':waeture2,
      'temperatuemax2': temperaturemax2,
      'temperaturemin2': temperaturemin2,
      'sunrise2': sunrise2,
      'sunset2': sunset2,
      'waeture3':waeture3,
      'temperatuemax3': temperaturemax3,
      'temperaturemin3': temperaturemin3,
      'sunrise3': sunrise3,
      'sunset3': sunset3,
        };
    final id = await db.insert('iteme1', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHe.db();
    return db.query('iteme1', orderBy: "id");
  }



 static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHe.db();
    return db.query('iteme1', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHe.db();
    try {
      await db.delete("iteme1", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
  static Future<void>  deleteAll() async {
    Database db = await SQLHe.db();
     await db.rawDelete("Delete from iteme1");
  }
}