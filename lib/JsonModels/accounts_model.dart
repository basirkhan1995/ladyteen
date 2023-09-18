
class AccountsModel{
  final int? pId;
  final String pName;
  final String? cardNumber;
  final String? cardName;
  final String jobTitle;
  final String? pImage;
  final String? pPhone;
  final String? accountType;
  final String? updatedAt;
  final String createdAt;
  AccountsModel({
    this.pId,
    required this.pName,
    required this.jobTitle,
    this.cardNumber,
    this.cardName,
    this.pImage,
    this.pPhone,
    required this.accountType,
    required this.createdAt,
    this.updatedAt
  });

  factory AccountsModel.fromMap(Map<String, dynamic> json) => AccountsModel(
    pId: json['accId'],
    pName: json ['accName'],
    cardNumber: json['cardNumber'],
    cardName: json['cardName'],
    jobTitle: json['jobTitle'],
    pImage: json['pImage'],
    pPhone: json['pPhone'],
    accountType: json['categoryName'],
    updatedAt: json['updatedAt'],
    createdAt: json['createdAt'],
  );

  Map<String, dynamic> toMap(){
    return{
      'accId':pId,
      'accName':pName,
      'cardNumber':cardNumber,
      'accountName':cardName,
      'jobTitle':jobTitle,
      'pImage':pImage,
      'pPhone':pPhone,
      'categoryName':accountType,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
    };
  }

}