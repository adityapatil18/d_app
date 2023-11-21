// add entry screen api

import 'dart:convert';

Date dateFromJson(String str) => Date.fromJson(json.decode(str));

String dateToJson(Date data) => json.encode(data.toJson());

class Date {
  int status;
  String message;
  List<Datum> data;
  int count;
  Total total;

  Date({
    required this.status,
    required this.message,
    required this.data,
    required this.count,
    required this.total,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  String id;
  String amount;
  String balanceBefore;
  String balanceAfter;
  String userId;
  String createdBy;
  String trnxType;
  DateTime trnxDate;
  String reference;
  String remark;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  List<UserDetail> userDetail;
  List<AdminDetail> adminDetail;

  Datum({
    required this.id,
    required this.amount,
    required this.balanceBefore,
    required this.balanceAfter,
    required this.userId,
    required this.createdBy,
    required this.trnxType,
    required this.trnxDate,
    required this.reference,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.userDetail,
    required this.adminDetail,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        amount: json["amount"],
        balanceBefore: json["balanceBefore"],
        balanceAfter: json["balanceAfter"],
        userId: json["userId"],
        createdBy: json["createdBy"],
        trnxType: json["trnxType"],
        trnxDate: DateTime.parse(json["trnxDate"]),
        reference: json["reference"],
        remark: json["remark"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        userDetail: List<UserDetail>.from(
            json["userDetail"].map((x) => UserDetail.fromJson(x))),
        adminDetail: List<AdminDetail>.from(
            json["adminDetail"].map((x) => AdminDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "amount": amount,
        "balanceBefore": balanceBefore,
        "balanceAfter": balanceAfter,
        "userId": userId,
        "createdBy": createdBy,
        "trnxType": trnxType,
        "trnxDate": trnxDate.toIso8601String(),
        "reference": reference,
        "remark": remark,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "userDetail": List<dynamic>.from(userDetail.map((x) => x.toJson())),
        "adminDetail": List<dynamic>.from(adminDetail.map((x) => x.toJson())),
      };
}

class AdminDetail {
  int identity;

  AdminDetail({
    required this.identity,
  });

  factory AdminDetail.fromJson(Map<String, dynamic> json) => AdminDetail(
        identity: json["Identity"],
      );

  Map<String, dynamic> toJson() => {
        "Identity": identity,
      };
}

class UserDetail {
  String firstName;
  String lastName;

  UserDetail({
    required this.firstName,
    required this.lastName,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
      };
}

class Total {
  String totalReceived;
  String totalGiven;
  String openingBalance;
  String closingBalance;

  Total({
    required this.totalReceived,
    required this.totalGiven,
    required this.openingBalance,
    required this.closingBalance,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        totalReceived: json["totalReceived"],
        totalGiven: json["totalGiven"],
        openingBalance: json["openingBalance"],
        closingBalance: json["closingBalance"],
      );

  Map<String, dynamic> toJson() => {
        "totalReceived": totalReceived,
        "totalGiven": totalGiven,
        "openingBalance": openingBalance,
        "closingBalance": closingBalance,
      };
}
