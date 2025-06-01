import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import '../models/kabupaten.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static sql.Database? _database;

  Future<sql.Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<sql.Database> _initDb() async {
    final path = join(await sql.getDatabasesPath(), 'kabupaten.db');
    return sql.openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE kabupaten(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            pusatPemerintahan TEXT,
            bupati TEXT,
            luas REAL,
            penduduk INTEGER,
            kecamatan INTEGER,
            kelurahan INTEGER,
            desa INTEGER,
            logoUrl TEXT,
            website TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertKabupaten(Kabupaten kab) async {
  final db = await database;
  try {
    await db.insert(
      'kabupaten',
      kab.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    print('Sukses simpan: ${kab.nama}');
  } catch (e) {
    print('Gagal simpan: $e');
  }
}


  Future<List<Kabupaten>> getKabupatenList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('kabupaten');
    return List.generate(maps.length, (i) => Kabupaten.fromMap(maps[i]));
  }

  Future<void> deleteAllKabupaten() async {
    final db = await database;
    await db.delete('kabupaten');
  }
}
