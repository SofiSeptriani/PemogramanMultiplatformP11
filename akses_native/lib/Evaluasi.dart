import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kabupaten/Kota di Riau',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Kabupaten> _kabupatens = [];
  Database? _database;

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      'kabupatens.db',
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE kabupatens (
            id INTEGER PRIMARY KEY,
            nama TEXT,
            pusat_pemerintahan TEXT,
            bupati_walikota TEXT,
            luas_wilayah TEXT,
            jumlah_penduduk TEXT,
            jumlah_kecamatan TEXT,
            jumlah_kelurahan TEXT,
            jumlah_desa TEXT,
            link TEXT
          )
        ''');
      },
    );
  }

  Future<void> _insertKabupaten(Kabupaten kabupaten) async {
    await _database?.insert('kabupatens', kabupaten.toMap());
  }

  Future<void> _getKabupatens() async {
    final List<Map<String, dynamic>> maps = await _database?.query('kabupatens') ?? [];
    setState(() {
      _kabupatens = maps.map((map) => Kabupaten.fromMap(map)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _initDatabase().then((_) {
      _getKabupatens();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kabupaten/Kota di Riau'),
      ),
      body: _kabupatens.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _kabupatens.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_kabupatens[index].nama),
                  subtitle: Text(_kabupatens[index].pusatPemerintahan),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailKabupaten(_kabupatens[index])),
                    );
                  },
                );
              },
            ),
    );
  }
}

class DetailKabupaten extends StatelessWidget {
  final Kabupaten _kabupaten;

  DetailKabupaten(this._kabupaten);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_kabupaten.nama),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(_kabupaten.logo),
            SizedBox(height: 16),
            Text(_kabupaten.nama),
            SizedBox(height: 16),
            Text('Pusat Pemerintahan: ${_kabupaten.pusatPemerintahan}'),
            SizedBox(height: 16),
            Text('Bupati/Walikota: ${_kabupaten.bupatiWalikota}'),
            SizedBox(height: 16),
            Text('Luas Wilayah: ${_kabupaten.luasWilayah}'),
            SizedBox(height: 16),
            Text('Jumlah Penduduk: ${_kabupaten.jumlahPenduduk}'),
            SizedBox(height: 16),
            Text('Jumlah Kecamatan: ${_kabupaten.jumlahKecamatan}'),
            SizedBox(height: 16),
            Text('Jumlah Kelurahan: ${_kabupaten.jumlahKelurahan}'),
            SizedBox(height: 16),
            Text('Jumlah Desa: ${_kabupaten.jumlahDesa}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await launch(_kabupaten.link);
              },
              child: Text('Link Kabupaten/Kota'),
            ),
          ],
        ),
      ),
    );
  }
}

class Kabupaten {
  int id;
  String nama;
  String logo;
  String pusatPemerintahan;
  String bupatiWalikota;
  String luasWilayah;
  String jumlahPenduduk;
  String jumlahKecamatan;
  String jumlahKelurahan;
  String jumlahDesa;
  String link;

  Kabupaten({
    required this.id,
    required this.nama,
    required this.logo,
    required this.pusatPemerintahan,
    required this.bupatiWalikota,
    required this.luasWilayah,
    required this.jumlahPenduduk,
    required this.jumlahKecamatan,
    required this.jumlahKelurahan,
    required this.jumlahDesa,
    required this.link,
  });

  factory Kabupaten.fromMap(Map<String, dynamic> map) {
    return Kabupaten(
      id: map['id'],
      nama: map['nama'],
      logo: map['logo'],
      pusatPemerintahan: map['pusat_pemerintahan'],
      bupatiWalikota: map['bupati_walikota'],
      luasWilayah: map['luas_wilayah'],
      jumlahPenduduk: map['jumlah_penduduk'],
      jumlahKecamatan: map['jumlah_kecamatan'],
      jumlahKelurahan: map['jumlah_kelurahan'],
      jumlahDesa: map['jumlah_desa'],
      link: map['link'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'logo': logo,
      'pusat_pemerintahan': pusatPemerintahan,
      'bupati_walikota': bupatiWalikota,
      'luas_wilayah': luasWilayah,
      'jumlah_penduduk': jumlahPenduduk,
      'jumlah_kecamatan': jumlahKecamatan,
      'jumlah_kelurahan': jumlahKelurahan,
      'jumlah_desa': jumlahDesa,
      'link': link,
    };
  }
}