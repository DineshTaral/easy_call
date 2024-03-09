import 'dart:convert';
import 'dart:io';

import 'package:easy_call/database_helper.dart';
import 'package:easy_call/models/contacts_model.dart';
import 'package:easy_call/sections/add_recipient_screen.dart';
import 'package:easy_call/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipientsListScreen extends StatefulWidget {
  const RecipientsListScreen({super.key});

  @override
  State<RecipientsListScreen> createState() => _RecipientsListScreenState();
}

class _RecipientsListScreenState extends State<RecipientsListScreen> {
  late List<ContactsModel> _contactsModelList;

  @override
  void initState() {
    super.initState();
    _contactsModelList = [];
    DatabaseHelper.instance.queryAllRows().then((value) {
      for (var val in value) {
        _contactsModelList.add(ContactsModel.fromJson(val));
      }
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipients"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => AddRecipientScreen()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: GridView.builder(

          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (ctx, index) {
            return InkWell(
              onTap: ()=>Utils.launchPhone(mobile: _contactsModelList[index].contact??''),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(File(_contactsModelList[index].image??'')))),
              ),
            );
          },
          itemCount: _contactsModelList.length ?? 0),
    );
  }
}
