import 'package:flutter/material.dart';

class AccountsReport extends StatefulWidget {
  const AccountsReport({super.key});

  @override
  State<AccountsReport> createState() => _AccountsReportState();
}

class _AccountsReportState extends State<AccountsReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("account reports")),
    );
  }
}
