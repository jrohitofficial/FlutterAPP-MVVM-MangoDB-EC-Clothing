class OrderResponse {
  String? sId;
  List<CartItems>? cartItems;
  int? totalAmount;
  String? user;
  String? paymentType;
  int? iV;

  OrderResponse(
      {this.sId,
      this.cartItems,
      this.totalAmount,
      this.user,
      this.paymentType,
      this.iV});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
    totalAmount = json['totalAmount'];
    user = json['user'];
    paymentType = json['paymentType'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    data['totalAmount'] = this.totalAmount;
    data['user'] = this.user;
    data['paymentType'] = this.paymentType;
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
