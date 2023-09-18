
class AccountCategoryModel{
  final int? acId;
  final String categoryName;
  AccountCategoryModel({
    this.acId,
    required this.categoryName});

  factory AccountCategoryModel.fromMap(Map<String, dynamic> json) => AccountCategoryModel(
      acId: json['acId'],
      categoryName: json ['categoryName'],
  );

  Map<String, dynamic> toMap(){
    return{
      'usrId':acId,
      'usrName':categoryName,
    };
  }
}