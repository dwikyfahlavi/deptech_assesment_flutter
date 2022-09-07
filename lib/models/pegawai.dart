class Pegawai {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? address;
  final String? gender;

  Pegawai(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.address,
      required this.gender});

  factory Pegawai.fromMap(Map<String, dynamic> json) => Pegawai(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        phone: json['phone'],
        address: json['address'],
        gender: json['gender'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'gender': gender,
    };
  }
}
