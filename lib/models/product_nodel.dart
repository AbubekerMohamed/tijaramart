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
      id: map['_id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      description: map['description'] as String,
      quantity: map['quantity'] as double,
      price: map['price'] as double,
      category: map['category'] as String,
      images: List<String>.from(
        (map['images'] as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
