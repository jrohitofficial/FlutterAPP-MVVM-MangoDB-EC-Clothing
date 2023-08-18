import 'cart.dart';

class CartResponse {
  String? sId;
  String? user;
  List<Cart>? cartItems;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CartResponse(
      {this.sId,
      this.user,
      this.cartItems,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CartResponse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    if (json['cartItems'] != null) {
      cartItems = <Cart>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(Cart.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class CartItems {
  int? producQuantity;
  String? sId;
  String? name;
  int? price;
  int? quantity;

  CartItems(
      {this.producQuantity, this.sId, this.name, this.price, this.quantity});

  CartItems.fromJson(Map<String, dynamic> json) {
    producQuantity = json['producQuantity'];
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['producQuantity'] = this.producQuantity;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}
