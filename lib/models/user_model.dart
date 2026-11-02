class UserModel {
  final String id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String? phone;
  final String? image;
  final String? accessToken;
  final String? refreshToken;

  const UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.image,
    this.accessToken,
    this.refreshToken,
  });

  String get fullName => '$firstName $lastName';

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'image': image,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, fullName: $fullName, email: $email)';
  }
}
