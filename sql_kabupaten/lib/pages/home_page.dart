import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/kabupaten.dart';
import 'detail_page.dart';
import 'add_kabupaten_page.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Kabupaten> kabList = [];

  @override
  void initState() {
    super.initState();
    fetchKabupaten();
  }

  void fetchKabupaten() async {
    final data = await DatabaseHelper().getKabupatenList();
    setState(() => kabList = data);
  }

  Future<void> navigateToAddPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddKabupatenPage()),
    );

    if (result == true) {
      fetchKabupaten(); // refresh data kalau ada update
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kabupaten/Kota di Riau')),
      body: kabList.isEmpty
          ? const Center(child: Text('Belum ada data'))
          : ListView.builder(
              itemCount: kabList.length,
              itemBuilder: (context, index) {
                final kab = kabList[index];
                return ListTile(
                  leading: Image.network(
                    kab.logoUrl,
                    width: 50,
                    height: 50,
                    errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                  ),
                  title: Text(kab.nama),
                  subtitle: Text('Bupati: ${kab.bupati}'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DetailPage(kabupaten: kab)),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddPage,
        child: const Icon(Icons.add),
        tooltip: 'Tambah Kabupaten',
      ),
    );
  }
}
