import 'Mezmur.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
   
  final Muzmur muzmur;
 const Body({required this.muzmur});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title: Text(muzmur.title),
        backgroundColor: Colors.green.withOpacity(0.6),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(muzmur.body,style: TextStyle(fontSize: 16),),
            ),
          ),
        ),
      ),
    );
  }
}