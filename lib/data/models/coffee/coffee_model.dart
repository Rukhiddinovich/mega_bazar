// import 'package:dio/dio.dart';
// import 'package:image_picker/image_picker.dart';
//
//
// class CoffeeModelFields {
//   static const String id = "_id";
//   static const String name = "name";
//   static const String type = "type";
//   static const String price = "price";
//   static const String description = "description";
//   static const String image = "image";
//
//   static const String modelTable = "model_table";
// }
//
// class CoffeeModel {
//   final int id;
//   final String name;
//   final String type;
//   final int price;
//   final String description;
//   final String image;
//
//   CoffeeModel({
//     this.id=0,
//     required this.name,
//     required this.image,
//     required this.description,
//     required this.price,
//     required this.type,
//   });
//
//   factory CoffeeModel.fromJson(Map<String, dynamic> json) {
//     return CoffeeModel(
//       id: json["id"]as int? ?? 0,
//         name: json["name"]as String? ?? "",
//         image:json["image"]as String? ?? "",
//         description:json["description"]as String? ?? "",
//         price: json["price"]as int? ?? 0,
//         type: json["type"]as String? ?? "",
//     );
//   }
//
//   CoffeeModel copyWith({
//     String? name,
//     String? image,
//     String? type,
//     String? description,
//     int? price,
//     int? id,
//   }) =>
//       CoffeeModel(
//         id: id?? this.id,
//         name: name?? this.name,
//         image: image?? this.image,
//         description: description?? this.description,
//         price: price?? this.price,
//         type: type?? this.type,
//       );
//
//   @override
//   String toString() {
//     return """
//       name: $name,
//       image: $image,
//       description: $description,
//       price: $price,
//       type: $type,
//     """;
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "name": name,
//       "image": image,
//       "description": description,
//       "price": price,
//       "type": type,
//     };
//   }
//
//   List<Object?> get props => [];
//
//   Future<FormData> getFormData() async {
//     XFile file = XFile(image);
//     String fileName = file.path.split('/').last;
//     return FormData.fromMap({
//       "name": name,
//       "description": description,
//       "type": type,
//       "price": price,
//       "image": await MultipartFile.fromFile(file.path, filename: fileName),
//     });
//   }
// }
class CoffeeModel {
  int count;
  int price;
  List<dynamic> coffeeImage;
  String categoryId;
  String coffeeId;
  String coffeeName;
  String description;
  String createdAt;
  String currency;

  CoffeeModel({
    required this.count,
    required this.price,
    required this.coffeeImage,
    required this.categoryId,
    required this.coffeeId,
    required this.coffeeName,
    required this.description,
    required this.createdAt,
    required this.currency,
  });

  CoffeeModel copyWith({
    int? count,
    int? price,
    List<dynamic>? coffeeImage,
    String? categoryId,
    String? coffeeId,
    String? coffeeName,
    String? description,
    String? createdAt,
    String? currency,
  }) {
    return CoffeeModel(
      count: count ?? this.count,
      price: price ?? this.price,
      coffeeImage: coffeeImage ?? this.coffeeImage,
      categoryId: categoryId ?? this.categoryId,
      coffeeId: coffeeId ?? this.coffeeId,
      coffeeName: coffeeName ?? this.coffeeName,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      currency: currency ?? this.currency,
    );
  }

  factory CoffeeModel.fromJson(Map<String, dynamic> jsonData) {
    return CoffeeModel(
      count: jsonData['count'] as int? ?? 0,
      price: jsonData['price'] as int? ?? 0,
      coffeeImage: (jsonData['coffeeImage'] as List<dynamic>? ?? []),
      categoryId: jsonData['categoryId'] as String? ?? '',
      coffeeId: jsonData['coffeeId'] as String? ?? '',
      coffeeName: jsonData['coffeeName'] as String? ?? '',
      description: jsonData['description'] as String? ?? '',
      createdAt: jsonData['createdAt'] as String? ?? '',
      currency: jsonData['currency'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'price': price,
      'coffeeImage': coffeeImage,
      'categoryId': categoryId,
      'coffeeId': coffeeId,
      'coffeeName': coffeeName,
      'description': description,
      'createdAt': createdAt,
      'currency': currency,
    };
  }

  @override
  String toString() {
    return '''
      count: $count,
      price: $price,
      coffeeImage: $coffeeImage,
      categoryId: $categoryId,
      coffeeId: $coffeeId,
      coffeeName: $coffeeName,
      description: $description,
      createdAt: $createdAt,
      currency: $currency
      ''';
  }
}
