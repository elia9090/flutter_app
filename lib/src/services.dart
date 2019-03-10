import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:flutter_app/src/model.dart';

class Services {
  static Future<List<Hotel>> fetchPost() async {
    final response =
        await http.get('https://services.lastminute.com/mobile/stubs/hotels');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      var hotels = List<Hotel>.from(json.decode(response.body)['hotels'].map((i) => Hotel.fromJson(i)));
      return hotels;

    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static List<Hotel> createHotelList(List data) {
    List<Hotel> list = new List();
    for (int i = 0; i < data.length; i++) {
      Hotel hotel = Hotel.fromJson(data[i]);
      list.add(hotel);
    }
    return list;
  }
}
