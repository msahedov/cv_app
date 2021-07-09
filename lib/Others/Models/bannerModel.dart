import 'dart:convert';
import 'dart:io';
import 'authModel.dart';
import 'package:http/http.dart' as http;

class BannerModel {
  final int id, categoryId;
  final String page_path, image;

  BannerModel({
    this.id,
    this.categoryId,
    this.image,
    this.page_path,
  });
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(id: json['id'], categoryId: json['categoryId'], image: json["image"], page_path: json["page_path "]);
  }

  // get All banners
  static Future<List<BannerModel>> get getAllBanners async {
    List<BannerModel> banners = [];
    final response = await http.get(Uri.http("$serverIP", "/api/v1/public/banners"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)["data"];
      for (Map banner in responseJson) {
        banners.add(BannerModel.fromJson(banner));
      }
      return banners;
    } else
      return null;
  }

  Future<BannerModel> getBannerById(int id) async {
    final String token = await Auth().getToken();
    final response = await http.get(Uri.http("$serverIP", "/api/v1/public/banners/$id"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)["data"];
      return BannerModel.fromJson(responseJson);
    } else
      return null;
  }
}
