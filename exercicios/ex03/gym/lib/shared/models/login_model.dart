class LoginModel {
  String? name;
  String? mail;
  String? password;
  bool? keepOn;

  LoginModel({this.name, this.mail, this.password, this.keepOn});

  LoginModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mail = json['mail'];
    password = json['password'];
    keepOn = json['keepOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['mail'] = mail;
    data['password'] = password;
    data['keepOn'] = keepOn;
    return data;
  }

  // String toString() {
  //   return "Name: $name \nE-mail: $mail \nPssword: $password";
  // }
}
