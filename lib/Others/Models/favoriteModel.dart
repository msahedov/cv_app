import 'dart:convert';
import 'dart:io';
import 'productModel.dart';
import 'authModel.dart';
import 'package:http/http.dart' as http;

class Favorites {
//get all favorite products
  Future<List<Product>> getAllFavoriteProducts({int userId}) async {
    List<Product> products = [];
    final String token = await Auth().getToken();
    final response = await http.get(Uri.http("$serverIP", "/api/v1/public/$userId/favoriteProducts"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)["data"];
      for (Map product in responseJson) {
        products.add(new Product.fromJson(product));
      }
      return products;
    } else
      return null;
  }

//  get Favorite by id
  Future<Product> getFavoriteById({int userId, int productId}) async {
    final String token = await Auth().getToken();
    final response = await http.get(Uri.http("$serverIP", "/api/v1/public/$userId/favoriteProducts/$productId"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200)
      return Product.fromJson(jsonDecode(response.body)["data"]);
    else
      return null;
  }

//delete favorite by id
  Future<bool> deleteFavoriteById({int userId, int productId}) async {
    final String token = await Auth().getToken();
    final response = await http.delete(Uri.http("$serverIP", "/api/v1/public/$userId/favoriteProducts/$productId"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }
}
