import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladyteen_system/Components/Methods/button.dart';
import 'package:ladyteen_system/Components/Methods/textfield.dart';
import 'package:ladyteen_system/JsonModels/accounts_model.dart';

import '../../SQLite/database_helper.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  late DatabaseHelper handler;
  late Future<List<AccountsModel>> accounts;

  final formKey = GlobalKey <FormState> ();
  final db = DatabaseHelper();

  final accountName = TextEditingController();
  final phone = TextEditingController();
  final cardName = TextEditingController();
  final cardNumber = TextEditingController();
  final jobTitle = TextEditingController();

  @override
  void initState() {
    handler = DatabaseHelper();
    accounts = handler.getAllAccounts();
    handler.initDB().whenComplete((){
      accounts = getAccounts();
    });
    super.initState();
  }

  Future<List<AccountsModel>> getAccounts()async{
    return await handler.getAllAccounts();
  }

  Future<void> _refresh()async{
    setState(() {
      accounts = getAccounts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("accounts".tr),
        actions: [
          IconButton(
              onPressed: (){
               _addAccount();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
          future: accounts,
          builder: (BuildContext context, AsyncSnapshot<List<AccountsModel>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.hasData && snapshot.data!.isEmpty){
            return const Center(child: Text("No accounts"));
          }else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }else{
            final items = snapshot.data ?? <AccountsModel>[];
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context,index){
              return ListTile(
                title: Text(items[index].accountName),
              );
            });
          }
          })
    );
  }

  _addAccount(){
   Get.dialog(
     AlertDialog(
       title: Text("accounts".tr),
       content: SizedBox(
         width: 320,
         height: Get.height *.8,
         child: Form(
           key: formKey,
           child: Column(
             children: [
             ZField(
                 icon: Icons.account_circle,
                 title: "account_name",
               validator: (value){
                 if(value!.isEmpty){
                   return "name_required";
                 }
                 return null;
               },
               controller: accountName,
               isRequire: true,
               trailing: Text("account_type"),
             ),

               ZField(
                 icon: Icons.account_circle,
                 title: "job_title",
                 validator: (value){
                   if(value!.isEmpty){
                     return "job_title_required";
                   }
                   return null;
                 },
                 controller: jobTitle,
                 isRequire: true,
               ),

               ZField(
                 icon: Icons.account_circle,
                 title: "job_title",
                 controller: accountName,
               ),

               ZField(
                 icon: Icons.account_circle,
                 title: "card_name",
                 controller: accountName,
               ),

               ZField(
                 icon: Icons.account_circle,
                 title: "card_number",
                 controller: accountName,

               ),

             ],
           ),
         ),
       ),

       actions: [
         Row(
           children: [
             ZButton(
               width: .1,
               label: "cancel".tr,
               onTap: (){},
             ),
             const SizedBox(width: 8),
             ZButton(
               width: .15,
               label: "create".tr,
               onTap: (){},
             ),

           ],
         )
       ],
     ),
   );
  }
}
