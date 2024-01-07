import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  String? id;
  final String name;
  final String description;
  final double quantity;
  final double price;
  final String category;
  final List<String> images;
  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.category,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'price': price,
      'category': category,
      'images': images,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'],
      //rating will be added
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
