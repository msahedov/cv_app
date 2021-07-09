import 'dart:convert';
import 'dart:io';
import 'authModel.dart';
import 'package:http/http.dart' as http;
import 'productModel.dart';

class OrderItem {
  final bool active;
  final String rating, countInStock, price, name_tm, name_ru, brand, description_tm, description_ru, totalPrice;
  final List<dynamic> images;
  final int id, subCategoryId, marketId, likeCount, viewCount, discount, numReviews, quantity;

  OrderItem(
      {this.totalPrice,
      this.quantity,
      this.active,
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
      this.images,
      this.numReviews});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    List image = json["images"] as List;
    List<dynamic> _images = image.map((value) => value).toList();

    return OrderItem(
        totalPrice: json["orderItems"]["totalPrice"],
        quantity: json["orderItems"]["quantity"],
        active: json["active"],
        rating: json["rating"],
        countInStock: json["countInStock"],
        price: json["price"],
        name_tm: json["name_tm"],
        name_ru: json["name_ru"],
        brand: json["brand"],
        description_tm: json["description_tm"],
        description_ru: json["description_ru"],
        id: json["id"],
        images: _images,
        subCategoryId: json["subCategoryId"],
        marketId: json["marketId"],
        likeCount: json["likeCount"],
        viewCount: json["viewCount"],
        discount: json["discount"],
        numReviews: json["numReviews"]);
  }
}

class Order {
  final int id, customerId;
  final bool isPaid, isDelivered, isSubmitted;
  final String shippingAddress, paidAt, paymentMethod, totalPrice, deliveredAt, updatedAt, deletedAt;
  final List<OrderItem> orderedItems;
  Order(
      {this.id,
      this.customerId,
      this.isPaid,
      this.paidAt,
      this.isDelivered,
      this.isSubmitted,
      this.shippingAddress,
      this.paymentMethod,
      this.totalPrice,
      this.deliveredAt,
      this.updatedAt,
      this.deletedAt,
      this.orderedItems});

  factory Order.fromJsonByID(Map<String, dynamic> json) {
    var orderedProductsJson = json["orderedProducts"] as List;

    List<OrderItem> _orderedProducts = orderedProductsJson.map((e) {
      return OrderItem.fromJson(e);
    }).toList();

    return Order(
        id: json["id"],
        customerId: json["customerId"],
        isPaid: json["isPaid"],
        isDelivered: json["isDelivered"],
        isSubmitted: json["isSubmitted"],
        shippingAddress: json["shippingAddress"],
        paymentMethod: json["paymentMethod"],
        totalPrice: json["totalPrice"],
        deliveredAt: json["deliveredAt"],
        updatedAt: json["updatedAt"],
        deletedAt: json["deletedAt"],
        paidAt: json["paidAt"],
        orderedItems: _orderedProducts);
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json["id"],
        customerId: json["customerId"],
        isPaid: json["isPaid"],
        isDelivered: json["isDelivered"],
        isSubmitted: json["isSubmitted"],
        shippingAddress: json["shippingAddress"],
        paymentMethod: json["paymentMethod"],
        totalPrice: json["totalPrice"],
        deliveredAt: json["deliveredAt"],
        updatedAt: json["updatedAt"],
        deletedAt: json["deletedAt"],
        paidAt: json["paidAt"]);
  }

//get all orders
  Future<List<Order>> getAllOrders({int userId}) async {
    List<Order> orders = [];
    final String token = await Auth().getToken();
    final response = await http.get(Uri.http("$serverIP", "/api/v1/public/$userId/orders"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)["data"];
      for (Map order in responseJson) {
        orders.add(new Order.fromJson(order));
      }
      return orders;
    } else
      return null;
  }

  //  get order by id
  Future<Order> getOrderById({int userId, int orderId}) async {
    final String token = await Auth().getToken();
    final response = await http.get(Uri.http("$serverIP", "/api/v1/public/$userId/orders/$orderId"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    print(jsonDecode(response.body)["data"]);
    if (response.statusCode == 200) {
      return Order.fromJsonByID(jsonDecode(response.body)["data"]);
    } else
      return null;
  }

//get ordered products with count and totalprice
  Future<Product> getOrderedItems({int userId, int orderId}) async {
    List<Product> products = [];
    final String token = await Auth().getToken();
    final response = await http.get(Uri.http("$serverIP", "/api/v1/public/$userId/orders/$orderId"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    return Product.fromJson(jsonDecode(response.body)["data"]["orderedProducts"]);
  }

//create new order
  Future<bool> createOrder({int userId, String paymentMethod, String shippingAddress}) async {
    final String token = await Auth().getToken();
    final response = await http.post(
      Uri.http("$serverIP", "/api/v1/public/$userId/orders"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode(<String, String>{"shippingAddress": shippingAddress, "paymentMethod": paymentMethod}),
    );
    if (response.statusCode == 201)
      return true;
    else
      return false;
  }

//update order by id
  Future<bool> updateOrderById({int userId, int orderId, String paymentMethod}) async {
    final String token = await Auth().getToken();
    final response = await http.put(
      Uri.http("$serverIP", "/api/v1/public/$userId/orders/$orderId"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode(<String, String>{"paymentMethod": paymentMethod}),
    );
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

//submit order by id
  Future<bool> submitOrderById({int userId, int orderId}) async {
    final String token = await Auth().getToken();
    final response = await http.post(Uri.http("$serverIP", "/api/v1/public/$userId/orders/$orderId"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }

//delete order by id
  Future<bool> deleteOrderById({int userId, int orderId}) async {
    final String token = await Auth().getToken();
    final response = await http.delete(Uri.http("$serverIP", "/api/v1/public/$userId/orders/$orderId"), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200)
      return true;
    else
      return false;
  }
}
