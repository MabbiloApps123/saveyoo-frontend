// To parse this JSON data, do
//
//     final productsResponse = productsResponseFromJson(jsonString);

import 'dart:convert';

ProductsResponse productsResponseFromJson(String str) =>
    ProductsResponse.fromJson(json.decode(str));

String productsResponseToJson(ProductsResponse data) =>
    json.encode(data.toJson());

class ProductsResponse {
  final List<Product> products;

  ProductsResponse({
    required this.products,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      ProductsResponse(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  final String id;
  final String name;
  final String description;
  final String category;
  final Price price;
  final Availability availability;
  final Store store;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.availability,
    required this.store,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        category: json["category"],
        price: Price.fromJson(json["price"]),
        availability: Availability.fromJson(json["availability"]),
        store: Store.fromJson(json["store"]),
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "category": category,
        "price": price.toJson(),
        "availability": availability.toJson(),
        "store": store.toJson(),
        "image_url": imageUrl,
      };
}

class Availability {
  final int quantity;
  final PickupTime pickupTime;

  Availability({
    required this.quantity,
    required this.pickupTime,
  });

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        quantity: json["quantity"],
        pickupTime: PickupTime.fromJson(json["pickup_time"]),
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "pickup_time": pickupTime.toJson(),
      };
}

class PickupTime {
  final DateTime start;
  final DateTime end;

  PickupTime({
    required this.start,
    required this.end,
  });

  factory PickupTime.fromJson(Map<String, dynamic> json) => PickupTime(
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
      );

  Map<String, dynamic> toJson() => {
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
      };
}

class Price {
  final double original;
  final double discounted;
  final String currency;

  Price({
    required this.original,
    required this.discounted,
    required this.currency,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        original: json["original"],
        discounted: json["discounted"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "original": original,
        "discounted": discounted,
        "currency": currency,
      };
}

class Store {
  final String id;
  final String name;
  final Address address;
  final Contact contact;

  Store({
    required this.id,
    required this.name,
    required this.address,
    required this.contact,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        address: Address.fromJson(json["address"]),
        contact: Contact.fromJson(json["contact"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address.toJson(),
        "contact": contact.toJson(),
      };
}

class Address {
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"],
        city: json["city"],
        state: json["state"],
        postalCode: json["postal_code"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "city": city,
        "state": state,
        "postal_code": postalCode,
        "country": country,
      };
}

class Contact {
  final String phone;
  final String email;

  Contact({
    required this.phone,
    required this.email,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "email": email,
      };
}
