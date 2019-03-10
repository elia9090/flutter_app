import 'package:flutter/material.dart';
import 'package:flutter_app/src/model.dart';
import 'package:flutter_app/src/detail.dart';

class Favourites extends StatelessWidget {
  final Set<Hotel> _saved;

  Favourites(this._saved);

  @override
  Widget build(BuildContext context) {
    Iterable<ListTile> tiles;

    if (_saved.length == 0) {
      return new Scaffold(
          appBar: new AppBar(
            title: const Text('My Favourite hotels'),
          ),
          body: Center(
              child: Text(
            "No favourite hotels",
            style: TextStyle(fontSize: 24),
          )));
    } else {
      tiles = _saved.map(
        (Hotel hotel) {
          return new ListTile(
            title: new Text(hotel.name, style: const TextStyle(fontSize: 18.0)),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (ctxt) => new Detail(hotel)),
              );
            },
          );
        },
      );
      final List<Widget> divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();

      return new Scaffold(
        appBar: new AppBar(
          title: const Text('My Favourite hotels'),
        ),
        body: new ListView(children: divided),
      );
    }
  }
}


