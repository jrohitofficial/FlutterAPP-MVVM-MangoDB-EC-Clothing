import 'package:flutter_library_managent/features/Home/data/model/image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? description;
  int? price;
  double? ratings;
  List<Images>? images;
  String? category;
  int? stock;
  int? NoOfReviews;
  String? createdAt;

  String? time;

  Product({
    this.id,
    this.name,
    this.price,
    this.ratings,
    this.category,
    this.stock,
    this.NoOfReviews,
    this.createdAt,
    this.images,
    this.time,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
