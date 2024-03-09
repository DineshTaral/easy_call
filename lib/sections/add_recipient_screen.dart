import 'dart:io';
import 'package:easy_call/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRecipientScreen extends StatefulWidget {
  const AddRecipientScreen({super.key});

  @override
  AddRecipientScreenState createState() => AddRecipientScreenState();
}

class AddRecipientScreenState extends State<AddRecipientScreen> {
  final _textFieldController1 = TextEditingController();
  final _textFieldController2 = TextEditingController();
  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
         print('No image selected.');
      }
    });
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> data = {
      'name': _textFieldController1.text,
      'contact': _textFieldController2.text,
      'image': _image?.path ?? '',
    };

    DatabaseHelper.instance.insert(data);
    //  String jsonData = jsonEncode(data);

    //  await prefs.setString('data', jsonData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data saved successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image != null
                ? Image.file(
                    _image!,
                    height: 100,
                  )
                : Text('No image selected'),
            ElevatedButton(
              onPressed: _getImage,
              child: Text('Select Image'),
            ),
            TextField(
              controller: _textFieldController1,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _textFieldController2,
              decoration: InputDecoration(labelText: 'Mobile'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
