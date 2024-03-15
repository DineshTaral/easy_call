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
  initData();
  }

  initData(){
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
                    MaterialPageRoute(builder: (c) => const AddRecipientScreen()));
              },
              icon: const Icon(Icons.add)),

          IconButton(
              onPressed: () {
              initData();
              },
              icon: const Icon(Icons.refresh)),

        ],
      ),
      body: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (ctx, index) {
            return InkWell(
              onTap: ()=>Utils.launchPhone(mobile: _contactsModelList[index].contact??''),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(_contactsModelList[index].image??'')))),
                               child: Container(
                    width: MediaQuery.of(context).size.width,
                   padding: const EdgeInsets.all(8),
                   decoration: BoxDecoration(color: Colors.black.withOpacity(.5)),
                   child: Text(_contactsModelList[index].name??'',style: const TextStyle(color: Colors.white),),
                               ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) =>  AddRecipientScreen(
                              contactsModel: _contactsModelList[index],
                            )));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(.5)

                      ),
                          child: const Icon(Icons.edit,size: 15,color: Colors.white,)),
                    ),
                  )
                ],
              ),
            );
          },
          itemCount: _contactsModelList.length ?? 0),
    );
  }
}
