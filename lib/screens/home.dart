import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_avanzado_2/models/band.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 10),
    Band(id: '2', name: 'Bon Jovi', votes: 10),
    Band(id: '3', name: 'Guns N Roses', votes: 10),
    Band(id: '4', name: 'Iron Maiden', votes: 10),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BandNames',
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, int index) => _bandTile(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Dismissible _bandTile(Band band) {
    return Dismissible(
      onDismissed: (direction) => print(direction),
      background: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10),
        color: Colors.red,
        child: Text("Eliminar", style: TextStyle(color: Colors.white)),
      ),
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 18),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = new TextEditingController();

    if (Platform.isIOS) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("New band name:"),
                content: TextField(
                  controller: textController,
                ),
                actions: [
                  MaterialButton(
                      child: Text("Add"),
                      elevation: 5,
                      textColor: Colors.blue,
                      onPressed: () => addBandToList(textController.text))
                ],
              ));
    } else if (Platform.isAndroid) {
      showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: Text("New band name:"),
                content: CupertinoTextField(
                  controller: textController,
                ),
                actions: [
                  CupertinoDialogAction(
                    child: Text("Add"),
                    onPressed: () => addBandToList(textController.text),
                  ),
                  CupertinoDialogAction(
                    child: Text("Dismiss"),
                    isDestructiveAction: true,
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ));
    }
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      bands.add(Band(id: bands.length.toString(), name: name, votes: 0));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
