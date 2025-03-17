import 'package:coolstore/domain/entities/product.dart';

class RatingModel extends Rating {
  final double rate;
  final int count;

  RatingModel({
    required this.rate,
    required this.count,
  }) : super(count: count, rate: rate);

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        rate: json["rate"]?.toDouble(),
        count: json["count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}
