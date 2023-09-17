
class AccountsModel{
  final int? pId;
  final String? pName;
  final String cardNumber;
  final String accountName;
  final String jobTitle;
  final String? pImage;
  final String? pPhone;
  final String? accountType;
  final String? updatedAt;
  final String? createdAt;
  AccountsModel({this.pId, this.pName,required this.jobTitle,required this.cardNumber,required this.accountName, this.pImage,this.pPhone,this.accountType, this.createdAt, this.updatedAt});

  factory AccountsModel.fromMap(Map<String, dynamic> json) => AccountsModel(
    pId: json['accId'],
    pName: json ['accName'],
    cardNumber: json['cardNumber'],
    accountName: json['cardName'],
    jobTitle: json['jobTitle'],
    pImage: json['pImage'],
    pPhone: json['pPhone'],
    accountType: json['accountType'],
    updatedAt: json['updatedAt'],
    createdAt: json['createdAt'],
  );

  Map<String, dynamic> toMap(){
    return{
      'pId':pId,
      'pName':pName,
      'cardNumber':cardNumber,
      'accountName':accountName,
      'jobTitle':jobTitle,
      'pImage':pImage,
      'pPhone':pPhone,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
    };
  }

}