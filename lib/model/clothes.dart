// To parse this JSON data, do
//
//     final clothes = clothesFromJson(jsonString);

import 'dart:convert';

List<Clothes> clothesFromJson(String str) =>
    List<Clothes>.from(json.decode(str).map((x) => Clothes.fromJson(x)));

String clothesToJson(List<Clothes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Clothes {
  Clothes({
    required this.index,
    required this.temp,
    required this.clothes,
  });

  int index;
  String temp;
  ClothesClass clothes;

  factory Clothes.fromJson(Map<String, dynamic> json) => Clothes(
        index: json["index"],
        temp: json["temp"],
        clothes: ClothesClass.fromJson(json["clothes"]),
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "temp": temp,
        "clothes": clothes.toJson(),
      };
}

class ClothesClass {
  ClothesClass({
    required this.coat,
    required this.top,
    required this.bottoms,
  });

  List<Bottom> coat;
  List<Bottom> top;
  List<Bottom> bottoms;

  factory ClothesClass.fromJson(Map<String, dynamic> json) => ClothesClass(
        coat: List<Bottom>.from(json["coat"].map((x) => Bottom.fromJson(x))),
        top: List<Bottom>.from(json["top"].map((x) => Bottom.fromJson(x))),
        bottoms:
            List<Bottom>.from(json["bottoms"].map((x) => Bottom.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "coat": List<dynamic>.from(coat.map((x) => x.toJson())),
        "top": List<dynamic>.from(top.map((x) => x.toJson())),
        "bottoms": List<dynamic>.from(bottoms.map((x) => x.toJson())),
      };
}

class Bottom {
  Bottom({
    required this.name,
    required this.image,
  });

  String name;
  String image;

  factory Bottom.fromJson(Map<String, dynamic> json) => Bottom(
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
      };
}
