import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Models extends StatefulWidget {
  const Models({super.key});

  @override
  State<Models> createState() => _ModelsState();
}

class _ModelsState extends State<Models> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("models".tr),
      ),
    );
  }
}
