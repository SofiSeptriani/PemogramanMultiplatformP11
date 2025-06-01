import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/kabupaten.dart';

class AddKabupatenPage extends StatefulWidget {
  const AddKabupatenPage({super.key});

  @override
  State<AddKabupatenPage> createState() => _AddKabupatenPageState();
}

class _AddKabupatenPageState extends State<AddKabupatenPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController pusatController = TextEditingController();
  final TextEditingController bupatiController = TextEditingController();
  final TextEditingController luasController = TextEditingController();
  final TextEditingController pendudukController = TextEditingController();
  final TextEditingController kecamatanController = TextEditingController();
  final TextEditingController kelurahanController = TextEditingController();
  final TextEditingController desaController = TextEditingController();
  final TextEditingController logoUrlController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    pusatController.dispose();
    bupatiController.dispose();
    luasController.dispose();
    pendudukController.dispose();
    kecamatanController.dispose();
    kelurahanController.dispose();
    desaController.dispose();
    logoUrlController.dispose();
    websiteController.dispose();
    super.dispose();
  }

  Future<void> simpanData() async {
    if (_formKey.currentState!.validate()) {
      final kab = Kabupaten(
        nama: namaController.text,
        pusatPemerintahan: pusatController.text,
        bupati: bupatiController.text,
        luas: double.tryParse(luasController.text) ?? 0,
        penduduk: int.tryParse(pendudukController.text) ?? 0,
        kecamatan: int.tryParse(kecamatanController.text) ?? 0,
        kelurahan: int.tryParse(kelurahanController.text) ?? 0,
        desa: int.tryParse(desaController.text) ?? 0,
        logoUrl: logoUrlController.text,
        website: websiteController.text,
      );

      await DatabaseHelper().insertKabupaten(kab);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Kabupaten')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama Kabupaten'),
                validator: (val) => val!.isEmpty ? 'Harus diisi' : null,
              ),
              TextFormField(
                controller: pusatController,
                decoration: const InputDecoration(labelText: 'Pusat Pemerintahan'),
                validator: (val) => val!.isEmpty ? 'Harus diisi' : null,
              ),
              TextFormField(
                controller: bupatiController,
                decoration: const InputDecoration(labelText: 'Bupati'),
                validator: (val) => val!.isEmpty ? 'Harus diisi' : null,
              ),
              TextFormField(
                controller: luasController,
                decoration: const InputDecoration(labelText: 'Luas Wilayah (km²)'),
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty ? 'Harus diisi' : null,
              ),
              TextFormField(
                controller: pendudukController,
                decoration: const InputDecoration(labelText: 'Jumlah Penduduk'),
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty ? 'Harus diisi' : null,
              ),
              TextFormField(
                controller: kecamatanController,
                decoration: const InputDecoration(labelText: 'Jumlah Kecamatan'),
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty ? 'Harus diisi' : null,
              ),
              TextFormField(
                controller: kelurahanController,
                decoration: const InputDecoration(labelText: 'Jumlah Kelurahan'),
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty ? 'Harus diisi' : null,
              ),
              TextFormField(
                controller: desaController,
                decoration: const InputDecoration(labelText: 'Jumlah Desa'),
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty ? 'Harus diisi' : null,
              ),
              TextFormField(
                controller: logoUrlController,
                decoration: const InputDecoration(labelText: 'URL Logo'),
                validator: (val) => val!.isEmpty ? 'Harus diisi' : null,
              ),
              TextFormField(
                controller: websiteController,
                decoration: const InputDecoration(labelText: 'Website Resmi'),
                validator: (val) => val!.isEmpty ? 'Harus diisi' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: simpanData,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
