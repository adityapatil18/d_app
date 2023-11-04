// To parse this JSON data, do
//
//     final allData = allDataFromJson(jsonString);

import 'dart:convert';

AllData allDataFromJson(String str) => AllData.fromJson(json.decode(str));

String allDataToJson(AllData data) => json.encode(data.toJson());

class AllData {
    int status;
    String message;
    List<Datum> data;

    AllData({
        required this.status,
        required this.message,
        required this.data,
    });

    factory AllData.fromJson(Map<String, dynamic> json) => AllData(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    IngBalance openingBalance;
    IngBalance closingBalance;
    int status;
    String id;
    String firstName;
    String lastName;
    String fullName;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String datumId;

    Datum({
        required this.openingBalance,
        required this.closingBalance,
        required this.status,
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.fullName,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.datumId,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        openingBalance: IngBalance.fromJson(json["openingBalance"]),
        closingBalance: IngBalance.fromJson(json["closingBalance"]),
        status: json["status"],
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        fullName: json["fullName"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        datumId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "openingBalance": openingBalance.toJson(),
        "closingBalance": closingBalance.toJson(),
        "status": status,
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "fullName": fullName,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "id": datumId,
    };
}

class IngBalance {
    String numberDecimal;

    IngBalance({
        required this.numberDecimal,
    });

    factory IngBalance.fromJson(Map<String, dynamic> json) => IngBalance(
        numberDecimal: json["\u0024numberDecimal"],
    );

    Map<String, dynamic> toJson() => {
        "\u0024numberDecimal": numberDecimal,
    };
}
