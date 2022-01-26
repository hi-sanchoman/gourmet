import 'dart:convert';

class Address {
  int? id;
  String? address;
  String? lat;
  String? lng;
  String? apt;
  String? porch;
  String? floor;

  int? deliveryPrice;
  int? deliveryTreshold;
  int? freeTreshold;

  Address({
    this.id,
    this.address,
    this.lat,
    this.lng,
    this.apt,
    this.porch,
    this.floor,
    this.deliveryPrice,
    this.deliveryTreshold,
    this.freeTreshold,
  });

  Address copyWith({
    int? id,
    String? address,
    String? lat,
    String? lng,
    String? apt,
    String? porch,
    String? floor,
    int? deliveryPrice,
    int? deliveryTreshold,
    int? freePrice,
  }) {
    return Address(
      id: id ?? this.id,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      apt: apt ?? this.apt,
      porch: porch ?? this.porch,
      floor: floor ?? this.floor,
      deliveryPrice: deliveryPrice ?? this.deliveryPrice,
      deliveryTreshold: deliveryTreshold ?? this.deliveryTreshold,
      freeTreshold: freeTreshold ?? this.freeTreshold,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'lat': lat,
      'lng': lng,
      'apt': apt,
      'porch': porch,
      'floor': floor,
      'delivery_price': deliveryPrice,
      'delivery_threshold': deliveryTreshold,
      'free_threshold': freeTreshold,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] != null ? map['id'] : null,
      address: map['address'] != null ? map['address'] : null,
      lat: map['lat'] != null ? map['lat'] : null,
      lng: map['lng'] != null ? map['lng'] : null,
      apt: map['apartment_office'] != null ? map['apartment_office'] : null,
      porch: map['porch'] != null ? map['porch'] : null,
      floor: map['floor'] != null ? map['floor'] : null,
      deliveryPrice:
          map['delivery_price'] != null ? map['delivery_price'] : null,
      deliveryTreshold:
          map['delivery_threshold'] != null ? map['delivery_threshold'] : null,
      freeTreshold:
          map['free_threshold'] != null ? map['free_threshold'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Address(id: $id, address: $address, lat: $lat, lng: $lng, apt: $apt, porch: $porch, floor: $floor, deliveryPrice: $deliveryPrice, deliveryTreshold: $deliveryTreshold, freeTreshold: $freeTreshold)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Address &&
        other.id == id &&
        other.address == address &&
        other.lat == lat &&
        other.lng == lng &&
        other.apt == apt &&
        other.porch == porch &&
        other.floor == floor;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        address.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        apt.hashCode ^
        porch.hashCode ^
        floor.hashCode;
  }

  static String getFullStr(Address address) {
    String res = '${address.address}';

    if (address.apt != null && address.apt!.isNotEmpty) {
      res += ', ${address.apt}';
    }

    if (address.porch != null && address.porch!.isNotEmpty) {
      res += ', ${address.porch}';
    }

    if (address.floor != null && address.floor!.isNotEmpty) {
      res += ', ${address.floor}';
    }

    return res;
  }
}
