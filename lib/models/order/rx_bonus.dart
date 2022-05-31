import 'dart:convert';

class RxBonus {
  double? bonusCan;
  double? bonusMax;
  // RxBonusDetails? details;

  RxBonus({
    this.bonusCan,
    this.bonusMax,
    // this.details,
  });

  Map<String, dynamic> toMap() {
    return {
      'Balance': bonusCan,
      'BonusBalance': bonusMax,
      // 'RegisterDetailResponseDtos': details,
      // 'bonus_returned': bonusReturned,
      // 'updated_at': updatedAt,
      // 'goods': goods,
      // 'status': status,
      // 'address': address,
      // 'user': user,
      // 'review': review,
      // 'comment': comment,
      // 'paymentStatus': paymentStatus,
      // 'deliveryType': deliveryType,
    };
  }

  factory RxBonus.fromMap(Map<String, dynamic> map) {
    // var goods = OrderItemList.fromMap(map['goods']);
    // print("prepare order goods..." + map['goods'].toString());
    // print(goods);

    return RxBonus(
      bonusCan: map['Balance'],
      bonusMax: map['BonusBalance'],
      // details: map['RegisterDetailResponseDtos'],

      // totalPrice: map['total_price'],
      // bonusReturned: map['bonus_returned'],
      // updatedAt: map['updated_at'],
      // goods:
      //     map['goods'] != null ? OrderItemList.fromMap(map['goods']) : null,
      // status: map['status'],
      // address: map['address'],
      // review: map['review'],
      // comment: map['comment'],
      // paymentStatus: map['payment_status'],
      // deliveryType: map['delivery_type'],
      // user: map['user'] != null ? OrderUser.fromMap(map['user']) : null
    );
  }

  String toJson() => json.encode(toMap());

  factory RxBonus.fromJson(String source) =>
      RxBonus.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RxBonus()';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RxBonus &&
        other.bonusCan == bonusCan &&
        other.bonusMax == other.bonusMax;
  }

  @override
  int get hashCode {
    return bonusCan.hashCode ^ bonusMax.hashCode;
  }
}
