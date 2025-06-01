import 'dart:async';
import 'package:akses_sqlite/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static Future<Database> db() async {
    String path = await getDatabasesPath();
    final database = openDatabase(
      join(path, 'contact.db'),
      onCreate: (database, version) async {
        await _createTable(database);
      }, 
      version: 1,
    );
    return database;
  }

  static Future _createTable(Database db) async {
    await db.execute(
      '''
      CREATE TABLE contacts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phone TEXT
      )
      '''
    );
  }

  static Future<List<Contact>> getContactList() async {
    final db = await DbHelper.db();

    final List<Map<String, dynamic>> maps = 
    await db.query('contacts', orderBy: 'name');

    return List.generate(maps.length, (i) {
      return Contact.forMap(maps[i]);
    });
  }

  static Future<int> insert(Contact contact) async {
    final db = await DbHelper.db();
    int count = await db.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return count;
  }

  static Future<int> update(Contact contact) async {
    final db = await DbHelper.db();
    int count = await db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
    return count;
  }

  static Future<int> delete(int id) async {
    final db = await DbHelper.db();
    int count = await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
    return count;
  }
}
