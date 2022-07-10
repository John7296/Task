// To parse this JSON data, do
//
//     final postProduct = postProductFromJson(jsonString);

import 'dart:convert';

PostProduct postProductFromJson(String str) => PostProduct.fromJson(json.decode(str));

String postProductToJson(PostProduct data) => json.encode(data.toJson());

class PostProduct {
  PostProduct({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory PostProduct.fromJson(Map<String, dynamic> json) => PostProduct(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.products,
    this.total,
  });

  List<Product>? products;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
    "total": total,
  };
}

class Product {
  Product({
    this.id,
    this.sku,
    this.name,
    this.description,
    this.image,
    this.price,
    this.specialPrice,
    this.availableFrom,
    this.availableTo,
    this.isVeg,
    this.variations,
  });

  int? id;
  String? sku;
  String ?name;
  String? description;
  String? image;
  String? price;
  dynamic? specialPrice;
  String? availableFrom;
  String? availableTo;
  String? isVeg;
  dynamic? variations;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    sku: json["sku"],
    name: json["name"],
    description: json["description"],
    image: json["image"] == null ? null : json["image"],
    price: json["price"],
    specialPrice: json["special_price"],
    availableFrom: json["available_from"],
    availableTo: json["available_to"],
    isVeg: json["is_veg"],
    variations: json["variations"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sku": sku,
    "name": name,
    "description": description,
    "image": image == null ? null : image,
    "price": price,
    "special_price": specialPrice,
    "available_from": availableFrom,
    "available_to": availableTo,
    "is_veg": isVeg,
    "variations": variations,
  };
}
