class User {
  String? name;
  String? mail;
  String? password;
  bool? keepOn;

  User({this.name, this.mail, this.password, this.keepOn});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mail = json['mail'];
    password = json['password'];
    keepOn = json['keepOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['mail'] = mail;
    data['password'] = password;
    data['keepOn'] = keepOn;
    return data;
  }

  String toString() {
    return "Name: $name \nE-mail: $mail \nPssword: $password";
  }
}
