class Admin {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;

  Admin({this.id, required this.firstName, required this.lastName, required this.email, required this.password});

  factory Admin.fromMap(Map<String, dynamic> json) => Admin(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        password: json['password'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
    };
  }
}
