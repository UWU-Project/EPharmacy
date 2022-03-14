class UserModel {
  String? id;
  String? email;
  String? name;
  String? imageURL;

  UserModel({this.id, this.email, this.name, this.imageURL});

  //receiving data from the server
  factory UserModel.fromMap(map) {
    return UserModel(
        id: map['id'],
        email: map['email'],
        name: map['name'],
        imageURL: map['imageURL']);
  }

  //sending data to the server
  Map<String, dynamic> toMap() {
    return {
      'uid': id,
      'email': email,
      'displayName': name,
    };
  }
}
