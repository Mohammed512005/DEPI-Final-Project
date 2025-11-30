import 'dart:io';

class ToolModel {
  final File image;
  String? imageUrl;
  final String toolName;
  final String category;
  final String condition;
  final String description;
  final double price;
  final int rentalPeriod;
  String? toolId;

  final String? latitude;
  final String? longitude;

  ToolModel({
    this.toolId,
    required this.image,
    this.imageUrl,
    required this.toolName,
    required this.category,
    required this.condition,
    required this.description,
    required this.price,
    required this.rentalPeriod,
    this.latitude,
    this.longitude,
  });
}
