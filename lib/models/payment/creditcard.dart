import 'dart:convert';

class CreditCard {
  String? cardId;
  String? cardStr;
  CreditCard({
    this.cardId,
    this.cardStr,
  });

  CreditCard copyWith({
    String? cardId,
    String? cardStr,
  }) {
    return CreditCard(
      cardId: cardId ?? this.cardId,
      cardStr: cardStr ?? this.cardStr,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'card_id': cardId,
      'card_num': cardStr,
    };
  }

  factory CreditCard.fromMap(Map<String, dynamic> map) {
    return CreditCard(
      cardId: map['card_id'] != null ? map['card_id'] : null,
      cardStr: map['card_num'] != null ? map['card_num'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditCard.fromJson(String source) =>
      CreditCard.fromMap(json.decode(source));

  @override
  String toString() => 'CreditCard(cardId: $cardId, cardStr: $cardStr)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreditCard &&
        other.cardId == cardId &&
        other.cardStr == cardStr;
  }

  @override
  int get hashCode => cardId.hashCode ^ cardStr.hashCode;
}
