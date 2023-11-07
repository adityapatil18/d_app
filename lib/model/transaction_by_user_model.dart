// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

Transaction transactionFromJson(String str) => Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
    int status;
    String message;
    List<Datitem> data;
    int count;
    Total total;

    Transaction({
        required this.status,
        required this.message,
        required this.data,
        required this.count,
        required this.total,
    });

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        status: json["status"],
        message: json["message"],
        data: List<Datitem>.from(json["data"].map((x) => Datitem.fromJson(x))),
        count: json["count"],
        total: Total.fromJson(json["total"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
        "total": total.toJson(),
    };
}

class Datitem {
    Amount amount;
    String id;
    String userId;
    String trnxType;
    Amount balanceBefore;
    Amount balanceAfter;
    String reference;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String datitemId;

    Datitem({
        required this.amount,
        required this.id,
        required this.userId,
        required this.trnxType,
        required this.balanceBefore,
        required this.balanceAfter,
        required this.reference,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.datitemId,
    });

    factory Datitem.fromJson(Map<String, dynamic> json) => Datitem(
        amount: Amount.fromJson(json["amount"]),
        id: json["_id"],
        userId: json["userId"],
        trnxType: json["trnxType"],
        balanceBefore: Amount.fromJson(json["balanceBefore"]),
        balanceAfter: Amount.fromJson(json["balanceAfter"]),
        reference: json["reference"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        datitemId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount.toJson(),
        "_id": id,
        "userId": userId,
        "trnxType": trnxType,
        "balanceBefore": balanceBefore.toJson(),
        "balanceAfter": balanceAfter.toJson(),
        "reference": reference,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "id": datitemId,
    };
}

class Amount {
    String numberDecimal;

    Amount({
        required this.numberDecimal,
    });

    factory Amount.fromJson(Map<String, dynamic> json) => Amount(
        numberDecimal: json["\u0024numberDecimal"],
    );

    Map<String, dynamic> toJson() => {
        "\u0024numberDecimal": numberDecimal,
    };
}

class Total {
    int totalReceived;
    int totalGiven;

    Total({
        required this.totalReceived,
        required this.totalGiven,
    });

    factory Total.fromJson(Map<String, dynamic> json) => Total(
        totalReceived: json["totalReceived"],
        totalGiven: json["totalGiven"],
    );

    Map<String, dynamic> toJson() => {
        "totalReceived": totalReceived,
        "totalGiven": totalGiven,
    };
}
