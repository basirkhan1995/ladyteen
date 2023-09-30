
class CuttingsModel{
  final int? cutId;
  final String modelName;
  final String modelCode;
  final String? modelImage;
  final int? qadMasrafi;
  final int? qty;
  final String? color;
  final int? rastaLine;
  final int? zigzalLine;
  final int? meyanLine;
  final String? createdAt;
  CuttingsModel({
    this.cutId,
    required this.modelName,
    required this.modelCode,
    this.modelImage,
    required this.qadMasrafi,
    required this.qty,
    this.color,
    this.rastaLine,
    this.zigzalLine,
    this.meyanLine,
    this.createdAt
  });

  factory CuttingsModel.fromMap(Map<String, dynamic> json) => CuttingsModel(
    cutId: json['cutId'],
    modelName: json ['modelName'],
    modelCode: json['modelCode'],
    modelImage: json['modelImage'],
    qadMasrafi: json['qad_masrafi'],
    qty: json['qty'],
    color: json['color'],
    rastaLine: json['rasta_line'],
    zigzalLine: json['zigzal_line'],
    meyanLine: json['meyan_line'],
    createdAt: json['cuttingDate'],
  );

  Map<String, dynamic> toMap(){
    return{
      'cutId':cutId,
      'modelName':modelName,
      'modelCode':modelCode,
      'modelImage':modelImage,
      'qad_masrafi':qadMasrafi,
      'qty':qty,
      'color':color,
      'rasta_line': rastaLine,
      'zigzal_line': zigzalLine,
      'meyan_line' : meyanLine,
      'cuttingDate': createdAt,
    };
  }

}