class UserModel{
  String? uid;
  String? email;
  String? displayName;

  UserModel({this.uid, this.email, this.displayName});

  //receiving data from the server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],

    );
  }
  //sending data to the server
  Map<String, dynamic> toMap(){
   return{
     'uid': uid,
     'email': email,
     'displayName' : displayName,
   };
  }


}