class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uID;
  bool? isEmailVerified;

  SocialUserModel(
      {this.name, this.email, this.phone, this.uID, this.isEmailVerified});
  factory SocialUserModel.fromJson(Map<String, dynamic>? json)=> SocialUserModel (
    name : json?['name'],
    email : json?['email'],
    phone : json?['phone'],
    uID : json?['uID'],
    isEmailVerified : json?['isEmailVerified']
  );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uID': uID,
      'isEmailVerified':isEmailVerified,
    };
  }
}
