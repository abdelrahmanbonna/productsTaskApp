import 'package:equatable/equatable.dart';
import 'category_enum.dart';
import 'rating_model.dart';

class Product extends Equatable {
    final int id;
    final String title;
    final double price;
    final String description;
    final Category category;
    final String image;
    final Rating rating;
    final bool isFavorite;

    const Product({
        required this.id,
        required this.title,
        required this.price,
        required this.description,
        required this.category,
        required this.image,
        required this.rating,
        this.isFavorite=false,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        category: getCategoryEnum(json["category"]),
        image: json["image"],
        rating: Rating.fromJson(json["rating"]),
        isFavorite: json['isFavorite'] ?? false,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category.name,
        "image": image,
        "rating": rating.toJson(),
        "isFavorite": isFavorite,
    };

    Product copyWith({
      int? id,
      String? title,
      double? price,
      String? description,
      Category? category,
      String? image,
      Rating? rating,
      bool? isFavorite,
    }) {
      return Product(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        description: description ?? this.description,
        category: category ?? this.category,
        image: image ?? this.image,
        rating: rating ?? this.rating,
        isFavorite: isFavorite ?? this.isFavorite,
      );
    }

    @override
    List<Object?> get props => [
      id,
      title,
      price,
      description,
      category,
      image,
      rating,
      isFavorite,
    ];
}
