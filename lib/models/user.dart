class UserModel{
  int? id;
  String username;
  String email;
  String firstName;
  String lastName;
  String gender;
  String image;
  String? token;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.token,
});

  static UserModel FromJson (dynamic json) => UserModel(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      gender: json["gender"],
      image: json["image"],
      token: json["token"]
  );
}