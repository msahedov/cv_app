import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'authModel.dart';

class UserModel {
  UserModel({this.updateAt, this.id, this.name, this.phoneNumber, this.passwordChangedAt, this.createdAt, this.role, this.image});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        passwordChangedAt: json["passwordChangedAt"],
        updateAt: json["updateAt"],
        createdAt: json["createdAt"],
        role: json["role"],
        image: json["image"]);
  }

  final int id;
  var image;
  bool loggedOut;
  final String name, phoneNumber, passwordChangedAt, updateAt, createdAt, role;

//get me
  static Future<UserModel> get getMe async {
    final token = await Auth().getToken();
    final response = await http.get(
      Uri.http("$serverIP", "/api/v1/auth/getMe"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200)
      return UserModel.fromJson(jsonDecode(response.body)["data"]);
    else
      return null;
  }

//sign up
  Future<dynamic> signUp({String name, String phoneNumber, String password, String verification_code}) async {
    final response = await http.post(Uri.http("$serverIP", "/api/v1/auth/signup"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{"name": name, "phoneNumber": phoneNumber, "password": password, "verification_code": verification_code}));

    if (response.statusCode == 201) {
      Auth().setToken(jsonDecode(response.body)["token"]);
      return UserModel.fromJson(jsonDecode(response.body)["data"]);
    } else if (response.statusCode == 401) {
      return jsonDecode(response.body)["error"];
    } else
      return null;
  }

//login user
  Future<UserModel> loginUser({String phoneNumber, String password}) async {
    final response = await http.post(Uri.http("$serverIP", "/api/v1/auth/login"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{"phoneNumber": "$phoneNumber", "password": password}));
    if (response.statusCode == 200) {
      await Auth().setToken(jsonDecode(response.body)["token"]);
      return UserModel.fromJson(jsonDecode(response.body)["data"]);
    } else
      return null;
  }

//log out
  Future<bool> logOut() async {
    final token = await Auth().getToken();
    final response = await http.put(Uri.http("$serverIP", "/api/v1/auth/logout"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 204) {
      return true;
    } else
      return false;
  }

//change password
  Future<bool> changePassword({String oldPassword, String newPassword}) async {
    final token = await Auth().getToken();
    final response = await http.put(Uri.http("$serverIP", "/api/v1/auth/changePassword"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        body: jsonEncode(<String, String>{"oldPassword": oldPassword, "newPassword": newPassword}));
    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }

  //change me
  Future<UserModel> changeMe({String name, var photo}) async {
    final token = await Auth().getToken();
    final response = await http.put(Uri.http("$serverIP", "/api/v1/auth/changeMe"),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{"name": name, "photo": photo}));
    if (response.statusCode == 200)
      return UserModel.fromJson(jsonDecode(response.body)["data"]);
    else
      return null;
  }

  ///delete me
  Future<bool> deleteMe(int id) async {
    final token = await Auth().getToken();
    final response = await http.delete(Uri.http("$serverIP", "/api/v1/auth/deleteMe"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200) {
      await Auth().remove();
      return true;
    } else
      return false;
  }

  //delete profile image
  static Future<bool> get deleteProfileImage async {
    final String token = await Auth().getToken();
    final response = await http.delete(
      Uri.http("$serverIP", "/api/v1/auth/deleteImage"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }
}
