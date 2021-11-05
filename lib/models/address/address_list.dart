import 'package:esentai/models/address/address.dart';

class AddressList {
  final List<Address>? items;

  AddressList({
    this.items,
  });

  factory AddressList.fromMap(Map<String, dynamic> map) {
    List<Address> items = [];
    List<dynamic> results = map['results'];

    items = results.map((item) => Address.fromMap(item)).toList();

    return AddressList(
      items: items,
    );
  }

  @override
  String toString() => 'AddressList(items: $items)';
}
