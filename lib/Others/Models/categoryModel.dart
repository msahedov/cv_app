import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'authModel.dart';

class SubCategory {
  final int id, categoryId;
  final String name_ru, name_tm;

  SubCategory({this.id, this.categoryId, this.name_tm, this.name_ru});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json["id"],
      categoryId: json["categoryId"],
      name_tm: json["name_tm"],
      name_ru: json["name_ru"],
    );
  }
}

class Category {
  final int id, numberOfSubCategories, numberOfBanners;
  final String name_tm, name_ru, image;
  final List<SubCategory> subcategories;
  Category({this.id, this.numberOfSubCategories, this.subcategories, this.name_tm, this.name_ru, this.image, this.numberOfBanners});

  factory Category.fromJsonByID(Map<String, dynamic> json) {
    List orderJsonList = json["subCategories"] as List;
    List<SubCategory> _subcategories = orderJsonList.map((value) => SubCategory.fromJson(value)).toList();

    return Category(
        id: json["id"],
        name_tm: json["name_tm"],
        name_ru: json["name_ru"],
        image: json["image"],
        numberOfSubCategories: json["numberOfSubCategories"],
        numberOfBanners: json["numberOfBanners"],
        subcategories: _subcategories);
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      name_tm: json["name_tm"],
      name_ru: json["name_ru"],
      image: json["image"],
      numberOfSubCategories: json["numberOfSubCategories"],
      numberOfBanners: json["numberOfBanners"],
    );
  }

  // get All Categories
  static Future<List<Category>> get getAllCategories async {
    List<Category> categories = [];
    final response = await http.get(Uri.http("$serverIP", "/api/v1/public/categories"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)["data"];
      for (Map category in responseJson) {
        categories.add(Category.fromJson(category));
      }
      return categories;
    } else
      return null;
  }

  Future<Category> getCategoryById(int id) async {
    final response = await http.get(Uri.http("$serverIP", "/api/v1/public/categories/$id"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)["data"];
      return Category.fromJsonByID(responseJson);
    } else
      return null;
  }
}
