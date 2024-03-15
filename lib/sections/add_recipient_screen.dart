import 'dart:io';
import 'package:easy_call/database_helper.dart';
import 'package:easy_call/models/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRecipientScreen extends StatefulWidget {
  final ContactsModel? contactsModel;
  const AddRecipientScreen({this.contactsModel,super.key});
  @override
  AddRecipientScreenState createState() => AddRecipientScreenState();
}

class AddRecipientScreenState extends State<AddRecipientScreen> {
  final _nameTextFieldController1 = TextEditingController();
  final _contactTextFieldController2 = TextEditingController();
  File? _image;

  @override
  initState(){
    super.initState();
    if(widget.contactsModel!=null){
      _nameTextFieldController1.text=widget.contactsModel?.name??'';
      _contactTextFieldController2.text=widget.contactsModel?.contact??'';
      _image=File(widget.contactsModel?.image??'');
    }

  }
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

    Map<String, dynamic> data = {
      'name': _nameTextFieldController1.text,
      'contact': _contactTextFieldController2.text,
      'image': _image?.path ?? '',
    };
    DatabaseHelper.instance.insert(data);
    ScaffoldMessenger.of(context).showSnackBar(
    const  SnackBar(content: Text('Data saved successfully')),
    );
  }

  Future<void> _updateData() async {

    Map<String, dynamic> data = {
      'name': _nameTextFieldController1.text,
      'contact': _contactTextFieldController2.text,
      'image': _image?.path ?? '',
      '_id':widget.contactsModel?.id,
    };
    DatabaseHelper.instance.update(data);
    ScaffoldMessenger.of(context).showSnackBar(
      const  SnackBar(content: Text('Data updated successfully')),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _nameTextFieldController1,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _contactTextFieldController2,
              decoration: const InputDecoration(labelText: 'Mobile'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 50,),

            ElevatedButton(
              onPressed: _getImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 50,),
            _image != null
                ? Image.file(
              _image!,
              height: 100,
            )
                : Text('No image selected'),
           const SizedBox(height: 20),
            ElevatedButton(
              onPressed: widget.contactsModel!=null?_updateData:_saveData,
              child:  Text(widget.contactsModel!=null?'update':'Save'),
            ),
          ],
        ),
      ),
    );
  }
}
