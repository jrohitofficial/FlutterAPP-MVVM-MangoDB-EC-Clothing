import 'dart:convert';

import 'cart.dart';

class OrderModel {
  List<Cart>? cartItems;
  double? totalAmount;
  String? paymentType;

  OrderModel({this.cartItems, this.totalAmount, this.paymentType});

  

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(cartItems != null){
      result.addAll({'cartItems': cartItems!.map((x) => x?.toJson()).toList()});
    }
    if(totalAmount != null){
      result.addAll({'totalAmount': totalAmount});
    }
    if(paymentType != null){
      result.addAll({'paymentType': paymentType});
    }
  
    return result;
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      cartItems: map['cartItems'] != null ? List<Cart>.from(map['cartItems']?.map((x) => Cart.fromJson(x))) : null,
      totalAmount: map['totalAmount']?.toDouble(),
      paymentType: map['paymentType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source));
}
