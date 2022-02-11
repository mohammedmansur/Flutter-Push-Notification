class Users {
  String? uid;
  String? name;
  String? token;

  Users({
    this.uid,
    this.name,
    this.token,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        uid: json['uid'],
        name: json['name'],
        token: json['token'],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "name": name,
        "token": token,
      };
}
