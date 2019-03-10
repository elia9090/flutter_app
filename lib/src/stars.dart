import 'package:flutter/material.dart';

class HotelStars extends StatelessWidget {

  final int stars;
  final Color color;

  HotelStars({this.stars = 0, this.color});

  Widget buildStar(BuildContext context, int index) {
    return new InkResponse(
      child: new Icon(
        Icons.star,
        color: color ?? Theme.of(context).primaryColor,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        children:
            new List.generate(stars, (index) => buildStar(context, index)));
  }
}
