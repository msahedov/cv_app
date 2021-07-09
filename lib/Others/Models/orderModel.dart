import 'dart:convert';
import 'dart:io';
import 'authModel.dart';
import 'package:http/http.dart' as http;

import 'productModel.dart';

class OrderItem {
  final int qty, orderId, productId;
  final String totalPrice;

  OrderItem({this.qty, this.orderId, this.productId, this.totalPrice});
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      orderId: json["orderId"],
      productId: json["productId"],
      qty: json["qty"],
      totalPrice: json["totalPrice"],
    );
  }
}

class Order {
  final int id, customerId;
  final bool isPaid, isDelivered, isSubmitted;
  final String shippingAddress, region, paidAt, paymentMethod, totalPrice, deliveredAt, createdAt, updatedAt, deletedAt;

  Order({
    this.id,
    this.customerId,
    this.isPaid,
    this.paidAt,
    this.isDelivered,
    this.isSubmitted,
    this.shippingAddress,
    this.region,
    this.paymentMethod,
    this.totalPrice,
    this.deliveredAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json["id"],
        customerId: json["customerId"],
        isPaid: json["isPaid"],
        isDelivered: json["isDelivered"],
        isSubmitted: json["isSubmitted"],
        shippingAddress: json["shippingAddress"],
        region: json["region"],
        paymentMethod: json["paymentMethod"],
        totalPrice: json["totalPrice"],
        deliveredAt: json["deliveredAt"],
        createdAt: json["createdAt"],
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
    return Order.fromJson(jsonDecode(response.body)["data"]);
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
