import 'dart:convert';
import 'dart:io';
import 'package:e_commerce_app/Others/Models/productModel.dart';
import 'package:http/http.dart' as http;
import 'authModel.dart';

class Cart {
  final bool active;
  final String rating, countInStock, price, name_tm, name_ru, brand, description_tm, description_ru;
  var images;
  final int id, subCategoryId, marketId, likeCount, viewCount, discount, numReviews, qty;

  Cart(
      {this.active,
      this.rating,
      this.countInStock,
      this.price,
      this.name_tm,
      this.name_ru,
      this.brand,
      this.description_tm,
      this.description_ru,
      this.id,
      this.subCategoryId,
      this.marketId,
      this.likeCount,
      this.viewCount,
      this.discount,
      this.numReviews,
      this.images,
      this.qty});

  factory Cart.fromJson(Map<String, dynamic> json) {
    List image = json["images"] as List;
    List<dynamic> _images = image.map((value) => value).toList();

    return Cart(
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
    );
  }

  //get all items from cart
  Future<List<Cart>> getAllItemsFromCart({int userId}) async {
    List<Cart> cartItems = [];
    final String token = await Auth().getToken();
    final response = await http.get(Uri.http("$serverIP", "/api/v1/public/$userId/carts"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)["data"];
      for (Map cartItem in responseJson) {
        cartItems.add(Cart.fromJson(cartItem));
      }
      return cartItems;
    } else
      return null;
  }

  // add product to cart by id
  Future<bool> addProductToCartById({int userId, int productId, int qty}) async {
    final String token = await Auth().getToken();
    final response = await http.post(
      Uri.http("$serverIP", "/api/v1/public/$userId/carts/$productId/add"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode(<String, int>{"quantity": qty}),
    );
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

  //remove product from cart by id
  Future<bool> removeProductFromCart({int userId, int productId}) async {
    final String token = await Auth().getToken();
    final response = await http.put(Uri.http("$serverIP", "/api/v1/public/$userId/carts/$productId/remove"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }

  //empty cart  request
  Future<bool> emptyCartRequest({int userId, int productId}) async {
    final String token = await Auth().getToken();
    final response = await http.put(Uri.http("$serverIP", "/api/v1/public/$userId/carts"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }
}
