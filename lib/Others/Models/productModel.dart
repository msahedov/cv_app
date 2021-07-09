import 'dart:convert';
import 'dart:io';
import 'package:e_commerce_app/Others/Models/common.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'authModel.dart';
import 'marketModel.dart';

class Product extends ChangeNotifier {
  Product({
    this.market,
    this.similarProducts,
    this.reviewedUsers,
    this.id,
    this.subCategoryId,
    this.marketId,
    this.countInStock,
    this.likeCount,
    this.viewCount,
    this.discount,
    this.numReviews,
    this.price,
    this.rating,
    this.name_tm,
    this.name_ru,
    this.brand,
    this.description_tm,
    this.description_ru,
    this.favored,
    this.quantityInCart,
    this.images,
    this.active,
  });

  factory Product.fromJsonByID(Map<String, dynamic> json) {
    List image = json["product"]["images"] as List;
    List<dynamic> _images = image.map((value) => value).toList();
    Market _market = Market.fromJson(json["product"]["market"]);
    List similarProductsJson = json["similarProducts"] as List;
    List<Product> _similarProducts = similarProductsJson.map((e) => Product.fromJson(e)).toList();
    return Product(
      id: json["product"]["id"],
      subCategoryId: json["product"]["subCategoryId"],
      marketId: json["product"]["marketId"],
      countInStock: json["product"]["countInStock"],
      likeCount: json["product"]["likeCount"],
      viewCount: json["product"]["viewCount"],
      discount: json["product"]["discount"],
      numReviews: json["product"]["numReviews"],
      price: json["product"]["price"],
      rating: json["product"]["rating"],
      name_tm: json["product"]["name_tm"],
      name_ru: json["product"]["name_ru"],
      brand: json["product"]["brand"],
      similarProducts: _similarProducts,
      description_tm: json["product"]["description_tm"],
      description_ru: json["product"]["description_ru"],
      images: _images,
      market: _market,
      active: json["product"]["active"],
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    List image = json["images"] as List;
    List<dynamic> _images = image.map((value) => value).toList();

    return Product(
        id: json["id"],
        subCategoryId: json["subCategoryId"],
        marketId: json["marketId"],
        countInStock: json["countInStock"],
        likeCount: json["likeCount"],
        viewCount: json["viewCount"],
        discount: json["discount"],
        numReviews: json["numReviews"],
        price: json["price"],
        rating: json["rating"],
        name_tm: json["name_tm"],
        name_ru: json["name_ru"],
        brand: json["brand"],
        description_tm: json["description_tm"],
        description_ru: json["description_ru"],
        images: _images,
        active: json["active"]);
  }

  factory Product.fromJsonAuthored(Map<String, dynamic> json) {
    List image = json["images"] as List;
    List<dynamic> _images = image.map((value) => value).toList();

    return Product(
        id: json["id"],
        subCategoryId: json["subCategoryId"],
        marketId: json["marketId"],
        countInStock: json["countInStock"],
        likeCount: json["likeCount"],
        viewCount: json["viewCount"],
        discount: json["discount"],
        numReviews: json["numReviews"],
        price: json["price"],
        rating: json["rating"],
        name_tm: json["name_tm"],
        name_ru: json["name_ru"],
        brand: json["brand"],
        description_tm: json["description_tm"],
        description_ru: json["description_ru"],
        images: _images,
        active: json["active"],
        favored: json["favored"],
        quantityInCart: json["quantityInCart"]);
  }

  final bool active, favored;
  final String rating, countInStock, price, name_tm, name_ru, brand, description_tm, description_ru;
  var images;
  final int id, subCategoryId, marketId, likeCount, viewCount, discount, numReviews, quantityInCart;
  final List<Product> similarProducts;
  var reviewedUsers;
  final Market market;

  // get All active Products
  Future<List<Product>> getAllProducts({Map<String, String> parametr}) async {
    List<Product> products = [];
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final token = await Auth().getToken();
    bool isLogin = _prefs.getBool("isLoggedIn");
    isLogin = isLogin == null ? false : isLogin;

    final response = isLogin
        ? await http.get(Uri.http("$serverIP", "/api/v1/public/products/authored/products", parametr), headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader: 'Bearer $token',
          })
        : await http.get(Uri.http("$serverIP", "/api/v1/public/products", parametr), headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          });

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)["data"];
      if (isLogin) {
        for (Map product in responseJson) {
          products.add(Product.fromJsonAuthored(product));
        }
      } else {
        for (Map product in responseJson) {
          products.add(Product.fromJson(product));
        }
      }

      return products;
    } else
      return null;
  }

  // get All active Products authored users
  Future<List<Product>> getAllProductsAuthored({Map<String, String> parametr}) async {
    List<Product> products = [];
    final token = await Auth().getToken();
    final response = await http.get(Uri.http("$serverIP", "/api/v1/public/products/authored/products", parametr), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)["data"];

      for (Map product in responseJson) {
        products.add(Product.fromJsonAuthored(product));
      }

      return products;
    } else
      return null;
  }

//get product by id
  Future<Product> getProductById(int id) async {
    final response = await http.get(Uri.http("$serverIP", "/api/v1/public/products/$id"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      return Product.fromJsonByID(jsonDecode(response.body)["data"]);
    } else
      return null;
  }

  Future getAllProductsMaxValue({Map<String, String> parametr}) async {
    final response = await http.get(Uri.http("$serverIP", "/api/v1/public/products", parametr), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      return responseJson["results"];
    } else
      return null;
  }

  //get product review
  static Future<List<Product>> getReviewById(int id) async {
    List<Product> products = [];

    final response = await http.get(Uri.http("$serverIP", "/api/v1/public/products/$id"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)["data"]["product"]["reviewedUsers"];
      for (Map product in responseJson) {
        products.add(new Product.fromJson(product));
      }
      return products;
    } else
      return null;
  }

  Stream<Product> getProductByIdStream(int id) async* {
    final response = await http.get(Uri.http("$serverIP", "/api/v1/public/products/$id"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      yield Product.fromJson(jsonDecode(response.body)["data"]["product"]);
    } else
      yield null;
  }

  //get product by id by productLikeProducts
  Future<List<Product>> productLikeProducts(int id) async {
    List<Product> products = [];
    final response = await http.get(Uri.http("$serverIP", "/api/v1/public/products/$id"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)["data"]["similarProducts"];
      for (Map product in responseJson) {
        products.add(new Product.fromJson(product));
      }
      return products;
    } else
      return null;
  }

  //Add to favorite

  Future<bool> addToFavoriteByID(int id) async {
    final String token = await Auth().getToken();
    final response = await http.post(Uri.http("$serverIP", "/api/v1/public/products/$id/favorite"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });

    if (response.statusCode == 204)
      return true;
    else
      return false;
  }

  //Like product by id
  Future<bool> likeProductById(int id) async {
    final String token = await Auth().getToken();
    final response = await http.post(Uri.http("$serverIP", "/api/v1/public/products/$id/like"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  //review product by id
  static Future<bool> reviewProductById({int userId, int productId, double rating, String description}) async {
    final String token = await Auth().getToken();
    final _body = jsonEncode(<String, dynamic>{"rating": rating, "description": description});
    final _header = <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    final response = await http.post(Uri.http("$serverIP", "/api/v1/public/$userId/reviews/$productId"), headers: _header, body: _body);
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }
}
