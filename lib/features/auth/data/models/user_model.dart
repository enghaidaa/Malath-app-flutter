class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    };
  }
}
