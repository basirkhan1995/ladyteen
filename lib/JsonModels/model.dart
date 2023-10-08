
class ModelsJson{
  final int? mId;
  final String modelName;
  final int modelCode;
  final String? textTile;
  final String? madeIn;
  final String? images;
  final double? rastaLine;
  final double? zigzalLine;
  final double? meyanLine;
  final String createdAt;

  ModelsJson({
    this.mId,
    required this.modelName,
    required this.modelCode,
    this.textTile,
    this.madeIn,
    this.images,
    this.rastaLine,
    this.zigzalLine,
    this.meyanLine,
    required this.createdAt,
  });

  factory ModelsJson.fromMap(Map<String, dynamic> json) => ModelsJson(
      mId: json['mId'],
      modelName: json ['modelName'],
      modelCode: json['modelCode'],
      textTile:json['txtName'],
      madeIn: json['madeIn'],
      images: json['modelImages'],
      rastaLine: json['rasta_line'],
      zigzalLine: json['zigzal_line'],
      meyanLine: json['meyan_line'],
      createdAt: json['createdAt'],
  );

  Map<String, dynamic> toMap(){
    return{
      'mId':mId,
      'modelName':modelName,
      'modelCode':modelCode,
      'txtName' :textTile,
      'madeIn': madeIn,
      'modelImages':images,
      'rasta_line':rastaLine,
      'zigzal_line':zigzalLine,
      'meyan_line':meyanLine,
      'createdAt':createdAt,
    };
  }

}