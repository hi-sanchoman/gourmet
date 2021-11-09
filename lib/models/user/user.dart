class User {
  int? id;
  String? fullname;
  String? username;
  String? email;
  List<dynamic>? addresses;
  double? loyaltyBalance;
  String? loyaltyNum;
  String? birthday;

  User(
      {this.id,
      this.fullname,
      this.username,
      this.email,
      this.addresses,
      this.loyaltyBalance,
      this.birthday,
      this.loyaltyNum});

  factory User.fromMap(Map<String, dynamic> json) => User(
      id: json["id"],
      fullname: json["full_name"],
      username: json["username"],
      email: json["email"],
      loyaltyBalance: json['balance'],
      loyaltyNum: json['card_code'],
      birthday: json['birthday'],
      addresses: null // TODO: address
      );
}
