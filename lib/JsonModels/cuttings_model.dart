
class CuttingsModel{
  final int? cutId;
  final String modelName;
  final String modelCode;
  final String? modelImage;
  final String? txtName;
  final int? qadMasrafi;
  final int? qty;
  final int? rastaLine;
  final int? zigzalLine;
  final int? meyanLine;
  final String? createdAt;
  CuttingsModel({
    this.cutId,
    required this.modelName,
    required this.modelCode,
    this.modelImage,
    this.txtName,
    required this.qadMasrafi,
    required this.qty,
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
    txtName: json['txtName'],
    qadMasrafi: json['qad_masrafi'],
    qty: json['qty'],
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
      'txtName':txtName,
      'qad_masrafi':qadMasrafi,
      'qty':qty,
      'rasta_line': rastaLine,
      'zigzal_line': zigzalLine,
      'meyan_line' : meyanLine,
      'cuttingDate': createdAt,
    };
  }

}