import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladyteen_system/JsonModels/cuttings_model.dart';

import '../../Components/Colors/colors.dart';
import '../../SQLite/database_helper.dart';

class Cuttings extends StatefulWidget {
  const Cuttings({super.key});

  @override
  State<Cuttings> createState() => _CuttingsState();
}

class _CuttingsState extends State<Cuttings> {

  late DatabaseHelper handler;
  late Future<List<CuttingsModel>> cuttings;
  final db = DatabaseHelper();

  final searchController = TextEditingController();

  @override
  void initState() {
    handler = DatabaseHelper();
    cuttings = handler.getAllCuttings();

    handler.initDB().whenComplete((){
      cuttings = getCuttings();
    });
    super.initState();
  }

  Future<List<CuttingsModel>> getCuttings()async{
    return await handler.getAllCuttings();
  }

  Future<void> _refresh()async{
    setState(() {
      cuttings = getCuttings();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                _searchModels(),
                _createCuttingButton(),

              ],
            ),
            Expanded(
              child: FutureBuilder(
                  future: cuttings,
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
                  }),
            ),
          ],
        )
    );
  }

  _createCuttingButton(){
    return //Create Button
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(8)
                ),

                child: IconButton(
                    hoverColor: Colors.transparent,
                    splashRadius: 8,
                    onPressed: (){

                    },
                    icon: Row(
                      children: [
                        Text("create_cutting".tr,style: const TextStyle(color: Colors.white),),
                        const SizedBox(width: 5),
                        const Icon(Icons.add,color: Colors.white),
                      ],
                    )),
              ),
            ),
          ],
        ),
      );
  }

  _searchModels(){
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
                   // models = searchModel();
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
