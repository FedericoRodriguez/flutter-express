/*import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String username;
  String score;

  User({
    this.id,
    this.username,
    this.score
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      username: json["username"],
      score: json["score"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "score":score,
  };
}*/