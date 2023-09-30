import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladyteen_system/JsonModels/account_category.dart';
import 'package:ladyteen_system/JsonModels/accounts_model.dart';
import 'package:ladyteen_system/Views/Accounts/Screens/accounts_details.dart';
import '../../../SQLite/database_helper.dart';


class AccountsReport extends StatefulWidget {
  const AccountsReport({super.key});

  @override
  State<AccountsReport> createState() => _AccountsReportState();
}

class _AccountsReportState extends State<AccountsReport> {
  late DatabaseHelper handler;
  late Future<List<AccountsModel>> accounts;

  final formKey = GlobalKey <FormState> ();
  final db = DatabaseHelper();

  int selectedCategoryId = 0;

  final searchController = TextEditingController();

  @override
  void initState() {
    handler = DatabaseHelper();
    accounts = handler.getAllAccounts();
    handler.initDB().whenComplete((){
      accounts = getAccounts();
    });
    super.initState();
    _refresh();
  }

  Future<List<AccountsModel>> getAccounts()async{
    return await handler.getAllAccounts();
  }

  Future<List<AccountsModel>> searchAccounts()async{
    return await handler.searchAccountByName(searchController.text);
  }

  Future<void> _refresh()async{
    setState(() {
      accounts = getAccounts();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Column(
          children: [
            const SizedBox(height: 8),
            //Header
            Row(
              children: [
                _searchAccounts(),
              ],
            ),
            const SizedBox(height: 8),
            //Body
            Expanded(
              child: FutureBuilder(
                  future: accounts,
                  builder: (BuildContext context, AsyncSnapshot<List<AccountsModel>> snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                    }else if(snapshot.hasData && snapshot.data!.isEmpty){
                      return Center(child: Text("no_data".tr));
                    }else if(snapshot.hasError){
                      return Text(snapshot.error.toString());
                    }else{
                      final items = snapshot.data ?? <AccountsModel>[];
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context,index){
                            return ListTile(
                              onTap: (){
                                Get.to(()=>AccountDetails(accounts: items[index]))?.then((value) {
                                  if(value){
                                    _refresh();
                                  }
                                });
                              },
                              tileColor: index % 2 == 1 ? Colors.grey.withOpacity(.05) : Colors.white,
                              subtitle: Text(items[index].pId.toString()),
                              leading: const CircleAvatar(
                                backgroundImage: AssetImage("assets/photos/no_user.jpg"),
                                radius: 30,
                              ),
                              title: Text(items[index].pName,style: const TextStyle(fontWeight: FontWeight.bold),),
                            );
                          });
                    }
                  }),
            ),
          ],
        )
    );
  }
  _addCategory(){
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      height: 40,

      child: DropdownSearch<AccountCategoryModel>(
        validator: (value){
          if(value == null){
            return "category_required";
          }
          return null;
        },
        popupProps: const PopupPropsMultiSelection.menu(
          fit: FlexFit.loose,
        ),
        asyncItems: (value) => db.getAccountCategory(),
        itemAsString: (AccountCategoryModel u) => u.categoryName,
        onChanged: (AccountCategoryModel? data) {
          setState(() {
            selectedCategoryId = data!.acId!.toInt();
          });
        },

        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            border: InputBorder.none,
            hoverColor: Colors.transparent,
            contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 15),
            hintStyle: TextStyle(fontSize: 15,fontFamily: "Dubai"),
            hintText: "category",
          ),
        ),
      ),
    );
  }



  _searchAccounts(){
    return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              width: 350,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.withOpacity(.5))
              ),
              child: TextFormField(
                onChanged: (value){
                  setState(() {
                    accounts = searchAccounts();
                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "search".tr,
                    icon: const Icon(Icons.search)
                ),
              ),
            ),
          ],
        )
    );
  }

}
