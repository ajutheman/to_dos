class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String latitude;
  final String longitude;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.latitude,
    required this.longitude,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      latitude: json['address']['geo']['lat'],
      longitude: json['address']['geo']['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}