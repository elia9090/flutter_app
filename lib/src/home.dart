import 'package:flutter/material.dart';
import 'package:flutter_app/src/favourites.dart';
import 'package:flutter_app/src/model.dart';
import 'package:flutter_app/src/stars.dart';
import 'package:flutter_app/src/detail.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeState extends State<Home> {
  var hotels = [];
  final Set<Hotel> _saved = new Set<Hotel>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    this.hotels = widget.hotels;
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels'),
        backgroundColor: Colors.pinkAccent,
        actions: <Widget>[
          new IconButton(
              icon: const Icon(Icons.favorite_border), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (ctxt) => new Favourites(_saved)),
    );
  }

  Widget _buildSuggestions() {
    return ListView.separated(
        itemCount: hotels.length,
        separatorBuilder: (context, index) => Divider(
              color: Colors.black,
            ),
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          return _buildRow(hotels[i]);
        });
  }

  Widget _buildRow(Hotel hotel) {
    final bool alreadySaved = _saved.contains(hotel);
    return ListTile(
      title: Text(
        hotel.name,
        style: _biggerFont,
      ),
      subtitle: new Table(
        children: [
          new TableRow(children: [
            Text(hotel.location.city + " , " + hotel.location.address)
          ]),
          new TableRow(
              children: [new HotelStars(stars: hotel.stars)]),
        ],
      ),
      leading: new IconButton(
        icon: new Icon(
          // Add the lines from here...
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.pinkAccent : null,
        ),
        onPressed: () {
          // Add 9 lines from here...
          setState(() {
            if (alreadySaved) {
              _saved.remove(hotel);
            } else {
              _saved.add(hotel);
            }
          });
        },
      ),
      trailing: new CircularPercentIndicator(
        radius: 45.0,
        lineWidth: 4.0,
        percent: hotel.userRating / 10,
        center: new Text(hotel.userRating.toString()),
        progressColor: Colors.pinkAccent,
      ),
      onTap: () {
        // Add 9 lines from here...
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (ctxt) => new Detail(hotel)),
        );
      },
    );
  }
}

class Home extends StatefulWidget {
  final List<Hotel> hotels;

  const Home({Key key, this.hotels}) : super(key: key);

  @override
  HomeState createState() => new HomeState();
}
