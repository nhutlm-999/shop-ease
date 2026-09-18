// 1.1 Tạo model Product với đầy đủ fields: 
// -- id, title, price, description, category, image, rating
// + Implement fromJson(), toJson(), toMap(), fromMap()
// + Override toString(), ==, hashCode

class Product {
  final String id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  // Tạo bản sao mới với những thuộc tính được ghi đè
  Product copyWith({
    String? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    double? rating,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      rating: rating ?? this.rating,
    );
  }


}