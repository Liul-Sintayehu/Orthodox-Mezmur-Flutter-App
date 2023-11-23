import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mezmur/favBody.dart';

import 'main.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final _mybox = Hive.box('mybox');
  List<Map<String, dynamic>> fav = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    read();
  }

  void read() {
    final data = _mybox.keys.map((e) {
      final item = _mybox.get(e);
      return {"key": e, "title": item["title"], "body": item["body"]};
    }).toList();
    setState(() {
      fav = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites titles'),
        backgroundColor: Colors.green.withOpacity(0.6),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: fav.length,
          itemBuilder: ((context, index) {
            return Card(
              elevation: 5,
              child: ListTile(
                title: Text(fav[index]["title"]),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          FavBody(favBody: fav[index]["body"])));
                },
              ),
            );
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _mybox.clear();
          read();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
            (Route<dynamic> route) => false,
          );
        },
        backgroundColor: Colors.red,
        child: Center(
            child: Text(
          'Clear',
        )),
      ),
    );
  }
}
