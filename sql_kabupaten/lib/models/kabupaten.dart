// lib/models/kabupaten.dart

class Kabupaten {
  final int? id;
  final String nama;
  final String pusatPemerintahan;
  final String bupati;
  final double luas;
  final int penduduk;
  final int kecamatan;
  final int kelurahan;
  final int desa;
  final String logoUrl;
  final String website;

  Kabupaten({
    this.id,
    required this.nama,
    required this.pusatPemerintahan,
    required this.bupati,
    required this.luas,
    required this.penduduk,
    required this.kecamatan,
    required this.kelurahan,
    required this.desa,
    required this.logoUrl,
    required this.website,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'pusatPemerintahan': pusatPemerintahan,
      'bupati': bupati,
      'luas': luas,
      'penduduk': penduduk,
      'kecamatan': kecamatan,
      'kelurahan': kelurahan,
      'desa': desa,
      'logoUrl': logoUrl,
      'website': website,
    };
  }

  factory Kabupaten.fromMap(Map<String, dynamic> map) {
    return Kabupaten(
      id: map['id'],
      nama: map['nama'],
      pusatPemerintahan: map['pusatPemerintahan'],
      bupati: map['bupati'],
      luas: map['luas'],
      penduduk: map['penduduk'],
      kecamatan: map['kecamatan'],
      kelurahan: map['kelurahan'],
      desa: map['desa'],
      logoUrl: map['logoUrl'],
      website: map['website'],
    );
  }
}
