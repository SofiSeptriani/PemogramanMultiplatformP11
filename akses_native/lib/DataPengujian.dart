import 'package:flutter/material.dart';

void main() {
  runApp(AccessFeatureApp());
}

class AccessFeatureApp extends StatelessWidget {
  const AccessFeatureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pengujian Praktikum',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AccessFeatureHome(),
    );
  }
}

class Contact {
  String name;
  String phone;

  Contact({required this.name, required this.phone});
}

class AccessFeatureHome extends StatefulWidget {
  const AccessFeatureHome({super.key});

  @override
  _AccessFeatureHomeState createState() => _AccessFeatureHomeState();
}

class _AccessFeatureHomeState extends State<AccessFeatureHome> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  final List<Contact> _contacts = [];
  String _message = '';
  int? _editingIndex; 
  void _insertContact() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final phone = _phoneController.text.trim();

      setState(() {
        _contacts.add(Contact(name: name, phone: phone));
        _message = 'Data berhasil terinput';
        _editingIndex = null;
      });
      _clearFields();
    }
  }

  void _updateContact() {
    if (_editingIndex == null) {
      setState(() {
        _message = 'Pilih data dari daftar untuk diubah terlebih dahulu';
      });
      return;
    }
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final phone = _phoneController.text.trim();

      setState(() {
        _contacts[_editingIndex!] = Contact(name: name, phone: phone);
        _message = 'Data berhasil diubah';
        _editingIndex = null;
      });
      _clearFields();
    }
  }

  void _deleteContactAt(int index) {
    setState(() {
      _contacts.removeAt(index);
      _message = 'Data berhasil dihapus';
      if (_editingIndex == index) {
        _editingIndex = null;
        _clearFields();
      } else if (_editingIndex != null && _editingIndex! > index) {
        _editingIndex = _editingIndex! - 1;
      }
    });
  }

  void _startEditingContact(int index) {
    final contact = _contacts[index];
    setState(() {
      _nameController.text = contact.name;
      _phoneController.text = contact.phone;
      _editingIndex = index;
      _message = '';
    });
  }

  void _clearFields() {
    _nameController.clear();
    _phoneController.clear();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Widget _buildContactItem(Contact contact, int index) {
    bool isEditingThis = _editingIndex == index;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.indigo.shade300,
          child: Text(contact.name[0].toUpperCase(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        title: Text(contact.name,
            style: TextStyle(
                fontWeight: isEditingThis ? FontWeight.bold : FontWeight.normal,
                color: isEditingThis ? Colors.indigo : null)),
        subtitle: Text(contact.phone),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.orange),
              tooltip: 'Edit',
              onPressed: () => _startEditingContact(index),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              tooltip: 'Delete',
              onPressed: () => _deleteContactAt(index),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pengujian Praktikum Access Feature'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama harus diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nomor telepon harus diisi';
                    }
                    if (!RegExp(r'^\d{9,}$').hasMatch(value.trim())) {
                      return 'Nomor telepon tidak valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: _editingIndex == null ? _insertContact : null, 
                        child: Text(
                          'Insert',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextButton(
                        onPressed: _updateContact, // Always enabled
                        child: Text(
                          'Update',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                if (_message.isNotEmpty)
                  Text(
                    _message,
                    style: TextStyle(
                      color: _message.contains('berhasil') ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
              ]),
            ),
            const SizedBox(height: 30),
            const Divider(height: 1),
            const SizedBox(height: 15),
            const Text(
              'Data Kontak',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, color: Colors.indigo),
            ),
            const SizedBox(height: 10),
            Container(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              child: _contacts.isEmpty
                  ? const Center(
                      child: Text(
                      'Belum ada data',
                      style: TextStyle(color: Colors.grey),
                    ))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _contacts.length,
                      itemBuilder: (context, index) =>
                          _buildContactItem(_contacts[index], index),
                    ),
            ),
          ]),
        ));
  }
}