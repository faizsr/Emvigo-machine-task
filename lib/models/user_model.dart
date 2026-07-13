class UserModel {
  final String firstName;
  final String lastName;
  final DateTime dob;
  final String gender;
  final String nationality;
  final String language;
  final String email;
  final String password;
  final String? confirmPassword;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.gender,
    required this.nationality,
    required this.language,
    required this.email,
    required this.password,
    this.confirmPassword,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      dob: json['dob'] is DateTime
          ? json['dob'] as DateTime
          : DateTime.tryParse(json['dob']?.toString() ?? '') ?? DateTime.now(),
      gender: json['gender']?.toString() ?? '',
      nationality: json['nationality']?.toString() ?? '',
      language: json['language']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      password: json['password']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'dob': dob.toIso8601String(),
      'gender': gender,
      'nationality': nationality,
      'language': language,
      'email': email,
      'password': password,
    };
  }
}
