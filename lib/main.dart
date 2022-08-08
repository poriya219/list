import 'package:flutter/material.dart';
import 'package:list/file_screen.dart';
import 'package:list/item_box.dart';
import 'package:list/lib.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Size size;
  late SharedPreferences pref;

  @override
  void initState() {
    super.initState();
    myInitializer();
  }

  myInitializer() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.04,
              ),
              InkWell(
                child: Row(
                  children: [
                    SizedBox(width: size.width * 0.04,),
                    Text('Save Data'),
                    Spacer(),
                    Icon(Icons.print),
                    SizedBox(width: size.width * 0.04,),
                  ],
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return File_Screen();
                  }),);
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Item Box'),
      ),

      body: FutureBuilder(
          future: loadData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              List<String> resaultlist = snapshot.data;
              int counter = resaultlist.length;
              return body(resaultlist, counter);
            } //
            else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await add();
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget body(List<String> list, int count) {
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No Item!'),
            SizedBox(
              height: size.height * 0.01,
            ),
            const Text('Press + to add some item!'),
          ],
        ),
      );
    } //
    else {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Item_Box(
            num: list[index],
            size: size,
            onpressed: () async {
              await delete(list[index]);
              setState(() {});
            },
          );
        },
        itemCount: count,
      );
    }
  }

  Future<bool> add() async {
    try {
      pref = await SharedPreferences.getInstance();
      int counter = pref.getInt('counter') ?? 0;
      counter++;
      List<String> itemlist = pref.getStringList('items') ?? [];
      itemlist.add('Item $counter');
      await pref.setInt('counter', counter);
      await pref.setStringList('items', itemlist);
      return true;
    } //
    catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<String>> loadData() async {
    pref = await SharedPreferences.getInstance();
    List<String> itemlist = pref.getStringList('items') ?? [];
    liststring = pref.getStringList('items').toString();
    return itemlist;
  }

  Future<bool> delete(String item) async {
    try {
      pref = await SharedPreferences.getInstance();
      List<String> itemlist = pref.getStringList('items') ?? [];
      itemlist.remove(item);
      await pref.setStringList('items', itemlist);
      return true;
    } //
    catch (e) {
      print(e);
      return false;
    }
  }
}
