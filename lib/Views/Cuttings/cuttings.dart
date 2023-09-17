import 'package:flutter/material.dart';
import 'package:ladyteen_system/JsonModels/cuttings_model.dart';

import '../../SQLite/database_helper.dart';

class Cuttings extends StatefulWidget {
  const Cuttings({super.key});

  @override
  State<Cuttings> createState() => _CuttingsState();
}

class _CuttingsState extends State<Cuttings> {

  late DatabaseHelper handler;
  late Future<List<CuttingsModel>> accounts;
  final db = DatabaseHelper();

  @override
  void initState() {
    handler = DatabaseHelper();
    accounts = handler.getAllCuttings();

    handler.initDB().whenComplete((){
      accounts = getCuttings();
    });
    super.initState();
  }

  Future<List<CuttingsModel>> getCuttings()async{
    return await handler.getAllCuttings();
  }

  Future<void> _refresh()async{
    setState(() {
      accounts = getCuttings();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: accounts,
            builder: (BuildContext context, AsyncSnapshot<List<CuttingsModel>> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }else if(snapshot.hasData && snapshot.data!.isEmpty){
                return const Center(child: Text("No cuttings"));
              }else if(snapshot.hasError){
                return Text(snapshot.error.toString());
              }else{
                final items = snapshot.data ?? <CuttingsModel>[];
                return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context,index){
                      return ListTile(
                        title: Text(items[index].modelName),
                      );
                    });
              }
            })
    );
  }
}
