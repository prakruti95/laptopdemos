import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dbhelper.dart';
import 'connectivity_helper.dart';
import 'api_service.dart';
import 'package:http/http.dart' as http;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ConnectivityHelper.monitorConnectivity();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Offline Sync with Image',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CategoryPage(),
    );
  }
}

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController _nameController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  final dbHelper = DBHelper();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) _image = File(pickedFile.path);
    });
  }

  Future<void> _saveData() async {
    if (_nameController.text.isEmpty || _image == null) return;
    bool online = await ConnectivityHelper.isOnline();
    if (online) {
      final request = http.MultipartRequest('POST', Uri.parse(APIService.insertUrl));
      request.fields['name'] = _nameController.text;
      request.files.add(await http.MultipartFile.fromPath('url', _image!.path));
      final res = await request.send();
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Uploaded online")));
      }
    } else {
      await dbHelper.insertCategory(_nameController.text, _image!.path, isSynced: false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Saved offline")));
    }
    _nameController.clear();
    setState(() => _image = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Category")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Category Name")),
            const SizedBox(height: 10),
            _image == null
                ? const Text("No image selected")
                : Image.file(_image!, height: 150),
            ElevatedButton(onPressed: _pickImage, child: const Text("Pick Image")),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _saveData, child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
