class cartResponse {
  String? sId;
  String? user;
  List<CartItems>? cartItems;
  String? createdAt;
  String? updatedAt;
  int? iV;

  cartResponse(
      {this.sId,
      this.user,
      this.cartItems,
      this.createdAt,
      this.updatedAt,
      this.iV});

  cartResponse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
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
  String? productName;
  int? productPrice;
  int? producQuantity;
  String? sId;

  CartItems(
      {this.productName, this.productPrice, this.producQuantity, this.sId});

  CartItems.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    productPrice = json['productPrice'];
    producQuantity = json['producQuantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['productPrice'] = this.productPrice;
    data['producQuantity'] = this.producQuantity;
    data['_id'] = this.sId;
    return data;
  }
}