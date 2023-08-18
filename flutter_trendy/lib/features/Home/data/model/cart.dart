class Cart {
  String? productName;
  int? productPrice;
  int? producQuantity;

  Cart({this.productName, this.productPrice, this.producQuantity});

  // fromJson
  Cart.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    productPrice = json['productPrice'];
    producQuantity = json['producQuantity'];
  }

  // toJson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['productName'] = productName;
    data['productPrice'] = productPrice;
    data['producQuantity'] = producQuantity;
    return data;
  }

  toMap() {}
}
