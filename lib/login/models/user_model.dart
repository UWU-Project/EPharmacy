class UserModel{
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? displayName;

  UserModel({this.uid, this.email, this.firstName, this.lastName, this.displayName});

  //receiving data from the server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      displayName: map['displayName'],

    );
  }
  //sending data to the server
  Map<String, dynamic> toMap(){
   return{
     'uid': uid,
     'email': email,
     'firstName': firstName,
     'lastName' : lastName,
     'displayName' : displayName,
   };
  }


}