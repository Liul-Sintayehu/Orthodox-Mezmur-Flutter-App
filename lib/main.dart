import 'package:mezmur/Favorite.dart';

import 'Body.dart';
import 'Mezmur.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share/share.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('myBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

//List<String> allNames = ["abel","benteke","melat","ደጅ ጠናሁ ቆይቼ ኪዳነምህረትን \nተጽናናሁኝ ረሳሁ ሀዘኔን \nየአምላክ እናት እመቤታችን /2/\nሞገስ ሁኚኝ ቀሪው ዘመኔን /2/ \nየመከራው ዘመን አለፈ እንደ ዋዛ \nአንቺን ተጠግቼ የዓለሟን ቤዛ \nየልጅሽ ቸርነት የአንቺም ደግነት \nባሪያሽን ሰወረኝ ከአስጨናቂው ሞት \nእናቴ ስምሽን ስጠራ \nአለፈ ያ ሁሉ መከራ \nእንባዬ በፊትሽ ፈሰሰ \nእምዬ ባንቺ ነው የታበሰ \nሰላም ለኪ \n\nልቤ ባንቺ ጸና ከፍ ከፍም አለ\nበጠላቶቼም ላይ አፌ ተናገረ \nበማዳንሽ ስራ ባሪያሽ ደስ ብሎኛል \nየሐያላኑን ቀስት ልጅሽ ሰብሮልኛል \nእናቴ ስምሽን ስጠራ \nአለፈ ያ ሁሉ መከራ \nእንባዬ በፊትሽ ፈሰሰ \nእምዬ ባንቺ ነው የታበሰ \nሰላም ለኪ \n\nእጄ ባዶ ሲሆን ወዳጆቼም ሸሹ \nበመርገም ምከራቸው ሊለያዩኝ ሲሹ \nእርሱ የሰጠኝን እርሱ ወሰደ አልኳቸው \nእመቤቴ አለችኝ ብዬ አሳፈርኳቸው \nእናቴ ስምሽን ስጠራ አለፈ ያ ሁሉ መከራ \nእንባዬ በፊትሽ ፈሰሰ እምዬ ባንቺ ነው የታበሰ \nሰላም ለኪ \n\nከአውደ ምህረቱ ሆኜ ስጠራት \nዘንበል ብላ አየችኝ ኪዳነ ምህረት \nሐሳብሽን ምንም የለም የሚመስለው \nእረፍት ያገኘሁት እናቴ ባንቺ ነው \nእናቴ ስምሽን ስጠራ አለፈ ያ ሁሉ መከራ \nእንባዬ በፊትሽ ፈሰሰ \nእምዬ ባንቺ ነው የታበሰ \nሰላም ለኪ"];
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Muzmur> muzmurs = allMuzmur;

  final _controller = TextEditingController();

  // Future<void> readJson() async {
  //   final String response = await rootBundle.toString();
  //   final data = await json.decode(response);
  //   setState(() {
  //     allNames = data;
  //   });
  // }
  int index = 0;

  final _myBox = Hive.box('myBox');
  List<dynamic> favorites = [];

  void read() {
    final data = _myBox.keys.map((e) {
      final item = _myBox.get(e);
      return item["title"];
    }).toList();
    setState(() {
      favorites = data;
    });
  }

  void add(int index, Map<String, dynamic> newItem) async {
    await _myBox.put(index, newItem);
    print('data added');
  }

  void delete(int index) async {
    await _myBox.delete(index);
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.withOpacity(0.6),
        title: Text("መዝሙር ደብተሬ"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(muzmurs.length.toString() + " መዝሙር"),
          )
        ],
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
               
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.25,
                color: Colors.green,
                child: Center(
                  child: Text(
                    'EOTC MEZMUR',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
              
              SizedBox(
                height: 50,
              ),
              const Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text("Developed by : Liul Sintayehu"),
                      Text("phone no. : +251916460977"),
                    ],
                  ))
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onChanged: search,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                hintText: "Search",
                suffix: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.green.withOpacity(0.6),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: muzmurs.length,
              itemBuilder: ((context, index) {
                final muzmur = muzmurs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    borderOnForeground: true,
                    child: ListTile(
                      title: Text(muzmur.title),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Body(muzmur: muzmur)));
                      },
                      trailing: IconButton(
                          onPressed: () {
                            //await _myBox.put(index, muzmur.title);
                            if (favorites.contains(muzmur.title)) {
                              delete(index);
                            } else {
                              add(index,
                                  {"title": muzmur.title, "body": muzmur.body});
                            }
                            read();
                          },
                          icon: favorites.contains(muzmur.title)
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(Icons.favorite_outline)),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        height: 60,
        selectedIndex: index,
        backgroundColor: Colors.green[300],
        onDestinationSelected: (value) => setState(() {
          index = value;
        }),
        destinations: [
          IconButton(
            onPressed: () {
              Share.share('check my app');
            },
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => Favorite())));
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ))
        ],
      ),
    );
  }

  void search(String query) {
    final suggestions = allMuzmur.where((element) {
      final muzmurTitle = element.title.toLowerCase();
      final input = query.toLowerCase();
      return muzmurTitle.contains(input);
    }).toList();
    setState(() {
      muzmurs = suggestions;
    });
  }
}
