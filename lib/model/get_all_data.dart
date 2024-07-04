// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

Transaction transactionFromJson(String str) =>
    Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
  int status;
  String message;
  List<Dataitem> data;
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
        data:
            List<Dataitem>.from(json["data"].map((x) => Dataitem.fromJson(x))),
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

class Dataitem {
  String id;
  String userId;
  String trnxType;
  String? trnxDate;
  String amount;
  String balanceBefore;
  String balanceAfter;
  String reference;
  DateTime createdAt;
  DateTime updatedAt;
  String remark;
  int? identity;

  Dataitem({
    required this.id,
    required this.userId,
    required this.trnxType,
    required this.trnxDate,
    required this.amount,
    required this.balanceBefore,
    required this.balanceAfter,
    required this.reference,
    required this.createdAt,
    required this.updatedAt,
    required this.remark,
    required this.identity,
  });

  factory Dataitem.fromJson(Map<String, dynamic> json) => Dataitem(
        id: json["_id"],
        userId: json["userId"],
        trnxType: json["trnxType"],
        trnxDate: json["trnxDate"],
        amount: json["amount"],
        balanceBefore: json["balanceBefore"],
        balanceAfter: json["balanceAfter"],
        reference: json["reference"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        remark: json["remark"],
        identity: json["identity"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "trnxType": trnxType,
        "trnxDate": trnxDate,
        "amount": amount,
        "balanceBefore": balanceBefore,
        "balanceAfter": balanceAfter,
        "reference": reference,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "remark": remark,
        "identity": identity,
      };
}

class Total {
  String totalReceived;
  String totalGiven;
  String totalFinal;

  Total({
    required this.totalReceived,
    required this.totalGiven,
    required this.totalFinal,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        totalReceived: json["totalReceived"],
        totalGiven: json["totalGiven"],
        totalFinal: json["final"],
      );

  Map<String, dynamic> toJson() => {
        "totalReceived": totalReceived,
        "totalGiven": totalGiven,
        "final": totalFinal,
      };
}
