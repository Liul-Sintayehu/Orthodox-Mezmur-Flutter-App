
import 'package:flutter/material.dart';

class FavBody extends StatelessWidget {
   
  final String favBody;
 const FavBody({required this.favBody});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title: Text('favorite body'),
        centerTitle: true,
        backgroundColor: Colors.green.withOpacity(0.6),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(favBody,style: TextStyle(fontSize: 16),),
            ),
          ),
        ),
      ),
    );
  }
}