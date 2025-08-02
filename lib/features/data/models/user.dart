import 'package:cloud_firestore/cloud_firestore.dart';

class Userdata {
  Timestamp? createdAt;
  int? status;
  String? uid;
  bool? isAnonymous;
  String? phoneNumber;
  bool? emailVerified;
  String? photoURL;
  String? email;
  String? displayName;
  String? password;
  String? tenantId;
  String? refreshToken;

  Userdata({
    this.createdAt,
    this.status,
    this.uid,
    this.isAnonymous,
    this.phoneNumber,
    this.emailVerified,
    this.photoURL,
    this.email,
    this.displayName,
    this.password,
    this.tenantId,
    this.refreshToken,
  });

  Userdata.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    status = json['status'];
    uid = json['uid'];
    isAnonymous = json['isAnonymous'];
    phoneNumber = json['phoneNumber'];
    emailVerified = json['emailVerified'];
    photoURL = json['photoURL'];
    email = json['email'];
    displayName = json['displayName'];
    password = json['password'];
    tenantId = json['tenantId'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['status'] = status;
    data['uid'] = uid;
    data['isAnonymous'] = isAnonymous;
    data['phoneNumber'] = phoneNumber;
    data['emailVerified'] = emailVerified;
    data['photoURL'] = photoURL;
    data['email'] = email;
    data['displayName'] = displayName;
    data['password'] = password;
    data['tenantId'] = tenantId;
    data['refreshToken'] = refreshToken;
    return data;
  }
}
