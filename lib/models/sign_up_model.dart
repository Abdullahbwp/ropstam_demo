class SignUpModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;

  SignUpModel({this.firstName, this.lastName, this.email, this.password});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
