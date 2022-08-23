class UserModel {
  String uid;
  String email;
  String name;
  String? photoURL;

  UserModel(
      {required this.uid,
      required this.email,
      required this.name,
      this.photoURL});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        name: map['firstName'] + ' ' + map['secondName'],
        photoURL: map['photo']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoURL,
    };
  }
}
