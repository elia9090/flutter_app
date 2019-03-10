class Hotel {
  int id;
  String name;
  Location location;
  Check checkIn;
  Check checkOut;
  Contact contact;
  int stars;
  List<String> images;
  double userRating;

  Hotel(
      {this.id,
      this.name,
      this.location,
      this.checkIn,
      this.checkOut,
      this.contact,
      this.stars,
      this.images,
      this.userRating});

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      name: json['name'],
      location: Location.fromJson(json['location']),
      checkIn: Check.fromJson(json['checkIn']),
      checkOut: Check.fromJson(json['checkOut']),
      contact: Contact.fromJson(json['contact']),
      stars: json['stars'],
      images: List<String>.from(json['images']),
      userRating: json['userRating'],
    );
  }
}

class Location {
  String city;
  String address;
  double latitude;
  double longitude;

  Location({this.city, this.address, this.latitude, this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      city: json['city'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class Check {
  String from;
  String to;

  Check({this.from, this.to});

  factory Check.fromJson(Map<String, dynamic> json) {
    return Check(from: json['from'], to: json['to']);
  }
}

class Contact {
  String phoneNumber;
  String email;

  Contact({this.phoneNumber, this.email});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(phoneNumber: json['phoneNumber'], email: json['email']);
  }
}
