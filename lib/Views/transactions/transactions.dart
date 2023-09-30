import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("transactions".tr),
      ),
      body: const Center(
        child: Text("Transactions"),
      ),
    );
  }
}
