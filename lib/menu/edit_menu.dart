import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:berry_happy/endpoints/endpoints.dart';
import 'package:berry_happy/dto/menu.dart'; // Assuming you have a Menu model defined

class EditMenu extends StatefulWidget {
  final Menu menu;

  const EditMenu({required this.menu, Key? key}) : super(key: key);

  @override
  _EditMenuState createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  File? galleryFile;
  final picker = ImagePicker();
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.menu.menuName);
    _descriptionController = TextEditingController(text: widget.menu.descMenu);
    _priceController = TextEditingController(text: widget.menu.menuPrice.toString());
    _selectedCategory = widget.menu.kategori;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _showPicker({required BuildContext context}) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> getImage(ImageSource img) async {
    final pickedFile = await picker.pickImage(source: img);
    setState(() {
      if (pickedFile != null) {
        galleryFile = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nothing is selected')),
        );
      }
    });
  }

  Future<void> _updateDataWithImage(BuildContext context) async {
  try {
    var request = http.MultipartRequest('POST', Uri.parse('${Endpoints.menuUpdate}/${widget.menu.idMenu}'));
    request.fields['id_menu'] = widget.menu.idMenu.toString();
    request.fields['nama_menu'] = _titleController.text;
    request.fields['desc_menu'] = _descriptionController.text;
    request.fields['harga_menu'] = _priceController.text;
    request.fields['kategori'] = _selectedCategory;

    if (galleryFile != null) {
      var multipartFile = await http.MultipartFile.fromPath('img', galleryFile!.path);
      request.files.add(multipartFile);
    }

    // Debug prints to verify request details
    debugPrint('Request URL: ${request.url}');
    debugPrint('Request Fields: ${request.fields}');
    debugPrint('Request Files: ${request.files}');

    var response = await request.send();
    if (response.statusCode == 200) {
      debugPrint('Menu updated successfully!');
      Navigator.pushReplacementNamed(context, '/dashboard-owner');
    } else {
      debugPrint('Error updating menu: ${response.statusCode}');
      var responseBody = await response.stream.bytesToString();
      debugPrint('Response body: $responseBody');
    }
  } catch (e) {
    if (e is http.ClientException) {
      debugPrint('ClientException: ${e.message}');
    } else if (e is SocketException) {
      debugPrint('SocketException: ${e.message}');
    } else {
      debugPrint('Exception: ${e.toString()}');
    }
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 204, 229),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Edit Menu",
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      color: const Color.fromARGB(225, 223, 6, 112),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Fill the form below to update the menu!",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showPicker(context: context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey.shade200),
                                    ),
                                  ),
                                  width: double.infinity,
                                  height: 150,
                                  child: galleryFile == null
                                      ? (widget.menu.imageUrl != null && widget.menu.imageUrl!.isNotEmpty
                                          ? Image.network("${Endpoints.baseUAS}/static/img/${widget.menu.imageUrl}")
                                          : Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.add_photo_alternate_outlined,
                                                    color: Colors.grey,
                                                    size: 50,
                                                  ),
                                                  Text(
                                                    'Pick your Image here',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      color: const Color.fromARGB(255, 124, 122, 122),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ))
                                      : Center(child: Image.file(galleryFile!)),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                                ),
                                child: TextField(
                                  controller: _titleController,
                                  decoration: const InputDecoration(
                                    hintText: "Title",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      // _title = value; // This line is not necessary
                                    });
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                                ),
                                child: TextField(
                                  controller: _descriptionController,
                                  decoration: const InputDecoration(
                                    hintText: "Description",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      // _description = value; // This line is not necessary
                                    });
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                                ),
                                child: TextField(
                                  controller: _priceController,
                                  decoration: const InputDecoration(
                                    hintText: "Price",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      // _price = int.tryParse(value) ?? 0; // This line is not necessary
                                    });
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: _selectedCategory,
                                  items: ["FOOD", "BAVERAGE"]
                                      .map((category) => DropdownMenuItem(
                                            value: category,
                                            child: Text(category),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedCategory = value!;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Category",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 250),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(225, 223, 6, 112),
        tooltip: 'Save',
        onPressed: () {
          _updateDataWithImage(context);
        },
        child: const Icon(Icons.save, color: Colors.white, size: 28),
      ),
    );
  }
}
