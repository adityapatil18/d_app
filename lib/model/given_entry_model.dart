import 'dart:convert';

GEntry gEntryFromJson(String str) => GEntry.fromJson(json.decode(str));

String gEntryToJson(GEntry data) => json.encode(data.toJson());

class GEntry {
  String? firstName;
  String? lastName;
  String? amount;
  String? type;
  int? status;
  String? id;

  GEntry({
    required this.firstName,
    required this.lastName,
    required this.amount,
    required this.type,
    required this.status,
    required this.id,
  });

  factory GEntry.fromJson(Map<String, dynamic> json) => GEntry(
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
