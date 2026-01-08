class UserModel {
  String? accessToken;

  UserModel({this.accessToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
  }
}
