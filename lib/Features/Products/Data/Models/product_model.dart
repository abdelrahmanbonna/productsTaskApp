import 'category_enum.dart';
import 'rating_model.dart';

class Product {
    final int id;
    final String title;
    final double price;
    final String description;
    final Category category;
    final String image;
    final Rating rating;

    Product({
        required this.id,
        required this.title,
        required this.price,
        required this.description,
        required this.category,
        required this.image,
        required this.rating,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        category: getCategoryEnum(json["category"]),
        image: json["image"],
        rating: Rating.fromJson(json["rating"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category.name,
        "image": image,
        "rating": rating.toJson(),
    };
}
