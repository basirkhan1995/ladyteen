import 'package:flutter/material.dart';
import 'package:ladyteen_system/JsonModels/model.dart';

class ModelDetails extends StatefulWidget {
  final ModelsJson models;
  const ModelDetails({super.key, required this.models});

  @override
  State<ModelDetails> createState() => _ModelDetailsState();
}

class _ModelDetailsState extends State<ModelDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.models.modelName),),
    );
  }
}
