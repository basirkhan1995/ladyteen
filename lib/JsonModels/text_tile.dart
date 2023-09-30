
class TextTileModel{
  final int? txtId;
  final String txtName;

  TextTileModel({this.txtId, required this.txtName});

  factory TextTileModel.fromMap(Map<String, dynamic> json) => TextTileModel(
    txtId: json['txtId'],
    txtName: json ['txtName'],
  );

  Map<String, dynamic> toMap(){
    return{
      'txtId':txtId,
      'txtName':txtName,
    };
  }

}