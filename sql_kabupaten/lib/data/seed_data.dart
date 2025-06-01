// lib/data/seed_data.dart

import '../db/database_helper.dart';
import '../models/kabupaten.dart';

Future<void> insertSampleData() async {
  final dbHelper = DatabaseHelper();
  await dbHelper.deleteAllKabupaten();

  final List<Kabupaten> sample = [
    Kabupaten(
      nama: 'Pekanbaru',
      pusatPemerintahan: 'Pekanbaru',
      bupati: 'Muflihun',
      luas: 632.26,
      penduduk: 983356,
      kecamatan: 12,
      kelurahan: 83,
      desa: 0,
      logoUrl: 'https://upload.wikimedia.org/wikipedia/id/1/1c/Lambang_Kota_Pekanbaru.png',
      website: 'https://www.pekanbaru.go.id/',
    ),
    Kabupaten(
      nama: 'Kampar',
      pusatPemerintahan: 'Bangkinang',
      bupati: 'Catur Sugeng Susanto',
      luas: 11128.54,
      penduduk: 800000,
      kecamatan: 21,
      kelurahan: 8,
      desa: 242,
      logoUrl: 'https://upload.wikimedia.org/wikipedia/id/d/d6/Lambang_Kabupaten_Kampar.png',
      website: 'https://www.kamparkab.go.id/',
    ),
  ];

  for (var kab in sample) {
    await dbHelper.insertKabupaten(kab);
  }
}

// Jalankan fungsi ini sekali saat initState (opsional)
// insertSampleData();
