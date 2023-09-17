import 'package:flutter/material.dart';

class GeneralReports extends StatefulWidget {
  const GeneralReports({super.key});

  @override
  State<GeneralReports> createState() => _GeneralReportsState();
}

class _GeneralReportsState extends State<GeneralReports> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("General reports"),
      ),
    );
  }
}
