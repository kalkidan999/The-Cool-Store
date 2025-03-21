// ignore_for_file: annotate_overrides, overridden_fields

import 'package:coolstore/data/models/rating_model.dart';
import 'package:coolstore/domain/entities/product.dart';

class ProductModel extends Product {
  final int id;

  final String title;

  final double price;

  final String description;

  final String category;

  final String image;

  final RatingModel rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  }) : super(
            id: id,
            title: title,
            description: description,
            category: category,
            image: image,
            price: price,
            rating: rating);

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        price: json["price"]?.toDouble(),
        description: json["description"] ?? "",
        category: json["category"] ?? "",
        image: json["image"] ?? "",
        rating: RatingModel.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating.toJson(),
      };

  factory ProductModel.empty() {
    return ProductModel(
      id: -1,
      title: "Empty",
      price: 0,
      image: "",
      description: "This is default description",
      category: "None",
      rating: RatingModel(rate: 0, count: 0),
    );
  }
}
