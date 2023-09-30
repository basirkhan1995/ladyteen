import 'package:flutter/material.dart';
import 'package:ladyteen_system/JsonModels/accounts_model.dart';
import 'package:ladyteen_system/SQLite/database_helper.dart';

class AccountDetails extends StatelessWidget {
  final AccountsModel? accounts;
  const AccountDetails({super.key, this.accounts});

  @override
  Widget build(BuildContext context) {
    final db = DatabaseHelper();
    return Scaffold(
      appBar: AppBar(
        title: Text(accounts?.pName??""),
      
      actions: [
        IconButton(onPressed: ()=>db.deleteAccount(accounts!.pId.toString(), context).whenComplete(() => Navigator.of(context).pop(true)), icon: const Icon(Icons.delete))
      ],
      ),
      
      
      body: const Column(
        children: [
          
        ],
      ),
    );
  }
}
