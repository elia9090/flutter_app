import 'package:flutter/material.dart';
import 'package:flutter_app/src/home.dart';
import 'package:flutter_app/src/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
            body: new FutureBuilder(
                future: Services.fetchPost(),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (!snapshot.hasData) {
                    if (snapshot.hasError) {
                      return new MaterialApp(
                          home: new Scaffold(
                              body: new Center(
                                child: Center(child: Text("Impossible to fetch hotels data", style: TextStyle(fontSize: 24))),
                              ),
                         )
                      );
                    } else {
                      return new MaterialApp(
                          home: new Scaffold(
                        body: new Center(
                          child: new CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Colors.pinkAccent),
                          ),
                        ),
                      ));
                    }
                  }

                  List hotels = snapshot.data;
                  return new MaterialApp(
                      title: 'Hotels app',
                      home: Home(hotels: hotels),
                      theme: new ThemeData(
                          primaryColor: Colors.pinkAccent));
                })));
  }
}
