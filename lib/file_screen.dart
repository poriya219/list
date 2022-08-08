import 'dart:io';

import 'package:flutter/material.dart';
import 'package:list/lib.dart';
import 'package:path_provider/path_provider.dart';

class File_Screen extends StatefulWidget {
  @override
  State<File_Screen> createState() => _File_ScreenState();
}

class _File_ScreenState extends State<File_Screen> {

 String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await write('itemData.txt', liststring);
              },
              child: Container(
                child: Text('Write Data'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await read('itemData.txt');
                showDialog(context: context, builder: (BuildContext context){
                  return AlertDialog(title: Text(text));
                },
                );
              },
              child: Container(
                child: Text('Read Data'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<File> write(String file_name, String text) async {
    try {
      final File file = await getfile(file_name);
      return file.writeAsString(text);
    } catch (e) {
      return File('');
    }
  }

  Future<String> read(String file_name) async {
    try {
      final File file = await getfile(file_name);
      text = await file.readAsString();
      return text;
    } catch (e) {
      return '-1';
    }
  }

  Future<File> getfile(String file_name) async {
    try {
      final Directory dir = await getApplicationDocumentsDirectory();
      final path = dir.path;
      final File file = File('$path/$file_name');
      return file;
    } catch (e) {
      return File('');
    }
  }
}
