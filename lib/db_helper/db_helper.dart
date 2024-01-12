import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'chats.db'),
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE chats(id TEXT PRIMARY KEY, userId TEXT, title TEXT, messages TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(
    String table,
    Map<String, Object> data,
    String where,
    String whereArg,
  ) async {
    final db = await DBHelper.database();
    db.update(
      table,
      data,
      where: '$where = ?',
      whereArgs: [whereArg],
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<void> deleteAll(String table) async {
    final db = await DBHelper.database();
    db.delete(table);
  }

  static Future<void> deleteOne(
    String table,
    String where,
    String whereArg,
  ) async {
    final db = await DBHelper.database();
    db.delete(
      table,
      where: '$where = ?',
      whereArgs: [whereArg],
    );
  }
}
