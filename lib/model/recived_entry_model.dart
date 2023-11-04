import 'dart:convert';

REntry rEntryFromJson(String str) => REntry.fromJson(json.decode(str));

String rEntryToJson(REntry data) => json.encode(data.toJson());

class REntry {
  String? firstName;
  String? lastName;
  String? amount;
  String? type;
  int? status;
  String? id;

  REntry({
    required this.firstName,
    required this.lastName,
    required this.amount,
    required this.type,
    required this.status,
    required this.id,
  });

  factory REntry.fromJson(Map<String, dynamic> json) => REntry(
        firstName: json["firstName"],
        lastName: json["lastName"],
        amount: json["amount"],
        type: json["type"],
        status: json["status"],
        id: json["Id"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "amount": amount,
        "type": type,
        "status": status,
        "Id": id,
      };
}
