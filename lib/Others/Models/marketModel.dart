import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'authModel.dart';

class Market {
  final int id, ownerId, numRatings;
  final String name_tm, name_ru, address_tm, address_ru, phoneNumber, rating;
  var images;
  Market({this.numRatings, this.phoneNumber, this.rating, this.id, this.name_tm, this.name_ru, this.address_tm, this.address_ru, this.images, this.ownerId});

  factory Market.fromJson(Map<String, dynamic> json) {
    List jsonImages = json["images"] as List;
    List<dynamic> _images = jsonImages.map((e) => e).toList();

    return Market(
        id: json['id'],
        name_tm: json['name_tm'],
        name_ru: json['name_ru'],
        address_tm: json['address_tm'],
        address_ru: json['address_ru'],
        images: _images,
        ownerId: json["ownerId"],
        phoneNumber: json["phoneNumber"],
        rating: json["rating"],
        numRatings: json["numRatings"]);
  }

  // get All Markets
  Future<List<Market>> getAllMarkets({Map<String, String> parametr}) async {
    List<Market> markets = [];
    final response = await http.get(Uri.http("$serverIP", "/api/v1/public/markets", parametr), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    });
    //print(response.body);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)["data"];
      for (Map market in responseJson) {
        markets.add(new Market.fromJson(market));
      }
      return markets;
    } else
      return null;
  }

  //get Market by id
  Future<Market> getMarketById(int id) async {
    final response = await http.get(Uri.http("$serverIP", "/api/v1/public/markets/$id"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200)
      return Market.fromJson(jsonDecode(response.body)["data"]);
    else
      return null;
  }

  //rate market by id
  Future<bool> rateMarketById(int marketId, double rating) async {
    String token = await Auth().getToken();
    final response = await http.post(Uri.http("$serverIP", "/api/v1/public/markets/$marketId/rate"),
        body: jsonEncode(<String, dynamic>{"rating": rating}),
        headers: <String, String>{HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8', HttpHeaders.authorizationHeader: 'Bearer $token'});

    if (response.statusCode == 200)
      return true;
    else
      return false;
  }
}
