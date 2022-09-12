import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper{
  static Future<void> insert(String table, Map<String, Object> data)async{
    final dbPath=await sql.getDatabasesPath();   // folder, uses to store data in data base
    final sqlDb =await sql.openDatabase(path.join(dbPath, 'places.db'), onCreate: (db, version) {
      return db.execute('CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);  
    await sqlDb.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );  // open data base
  }
}