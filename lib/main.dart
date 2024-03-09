import 'package:easy_call/sections/recipients_list_screen.dart';
import 'package:flutter/material.dart';


main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RecipientsListScreen(),
    );
  }
}
