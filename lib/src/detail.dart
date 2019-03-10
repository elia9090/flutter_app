import 'package:flutter/material.dart';
import 'package:flutter_app/src/model.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageHeader implements SliverPersistentHeaderDelegate {
  ImageHeader(
      {this.onLayoutToggle,
      this.minExtent,
      this.maxExtent,
      this.url,
      this.name});

  final VoidCallback onLayoutToggle;
  final url;
  final name;
  double maxExtent;
  double minExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          this.url,
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black54,
              ],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Text(
            this.name,
            style: TextStyle(fontSize: 28.0, color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;
}

class Detail extends StatelessWidget {
  final Hotel _hotel;

  final _biggerFont = const TextStyle(fontSize: 18.0, color: Colors.black54);

  Detail(this._hotel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _scrollView(context),
      appBar: new AppBar(
        title: const Text('Hotel detail'),
      ),
    );
  }

  Widget _scrollView(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: ImageHeader(
              minExtent: 150.0,
              maxExtent: 250.0,
              url: _hotel.images[0],
              name: _hotel.name,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == 1)
                  return Container(
                    child: CarouselSlider(
                      height: 300.0,
                      autoPlay: false,
                      aspectRatio: 2.0,
                      items: _hotel.images.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                padding: new EdgeInsets.only(bottom: 30.0),
                                height: 200.0,
                                child: new Image.network(
                                  i,
                                  fit: BoxFit.cover,
                                ));
                          },
                        );
                      }).toList(),
                    ),
                  );

                if (index == 0)
                  return Container(
                    padding: new EdgeInsets.all(10.0),
                    child: new Column(children: [
                      //ROW ADDRESS
                      createRow(
                          Icons.location_city,
                          _hotel.location.city +
                              ", " +
                              _hotel.location.address),
                      //ROW STARS
                      createRow(Icons.star, _hotel.stars.toString() + " Stars"),
                      // ROW CHECK-IN
                      createRow(
                          Icons.access_time,
                          "Check-in: " +
                              _hotel.checkIn.from +
                              " - " +
                              _hotel.checkIn.to),
                      // ROW CHECK-OUT
                      createRow(
                          Icons.access_time,
                          "Check-out: " +
                              _hotel.checkOut.from +
                              " - " +
                              _hotel.checkOut.to),
                      // ROW E-MAIL
                      createRow(
                          Icons.mail_outline, "Mail: " + _hotel.contact.email),
                      // ROW PHONE
                      createRow(
                          Icons.phone, "Phone: " + _hotel.contact.phoneNumber),
                      // ROW USERS RATING
                      createRow(Icons.favorite,
                          "Users rating: " + _hotel.userRating.toString()),
                    ]),
                  );
              },
              childCount: 2,
            ),
          ),
        ],
      ),
    );
  }

  Row createRow(IconData icon, String descriptionLabel) {
    return new Row(children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 20, bottom: 20),
      ),
      Expanded(
        flex: 1, // 20%
        child: Icon(icon),
      ),
      Expanded(
        flex: 9, // 60%
        child: Text(descriptionLabel, style: _biggerFont),
      ),
    ]);
  }
}
