import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladyteen_system/Components/Colors/colors.dart';
import 'package:ladyteen_system/Components/Methods/button.dart';
import 'package:ladyteen_system/Components/Methods/textfield.dart';
import '../../../SQLite/database_helper.dart';
import '../../JsonModels/model.dart';
import '../../JsonModels/text_tile.dart';

class Models extends StatefulWidget {
  const Models({super.key});

  @override
  State<Models> createState() => _ModelsState();
}

class _ModelsState extends State<Models> {
  late DatabaseHelper handler;
  late Future<List<ModelsJson>> models;

  final formKey = GlobalKey <FormState> ();
  final db = DatabaseHelper();

  int selectedCategoryId = 0;

  final modelName = TextEditingController();
  final modelCode = TextEditingController();
  final madeIn = TextEditingController();
  final rasta = TextEditingController();
  final zigzal = TextEditingController();
  final meyan = TextEditingController();
  PlatformFile? file;
  final searchController = TextEditingController();

  @override
  void initState() {
    handler = DatabaseHelper();
    models = handler.getAllModels();
    handler.initDB().whenComplete((){
      models = getModels();
    });
    super.initState();
    _refresh();
  }

  Future<List<ModelsJson>> getModels()async{
    return await handler.getAllModels();
  }

  Future<List<ModelsJson>> searchModel()async{
    return await handler.searchModels(searchController.text);
  }

  Future<void> _refresh()async{
    setState(() {
      models = getModels();

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
                _searchModels(),
                _createModelButton(),

              ],
            ),
            const SizedBox(height: 8),
            //Body
            Expanded(
              child: FutureBuilder(
                  future: models,
                  builder: (BuildContext context, AsyncSnapshot<List<ModelsJson>> snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                    }else if(snapshot.hasData && snapshot.data!.isEmpty){
                      return Center(child: Text("no_data".tr));
                    }else if(snapshot.hasError){
                      return Text(snapshot.error.toString());
                    }else{
                      final items = snapshot.data ?? <ModelsJson>[];
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context,index){
                            return ListTile(
                              tileColor: index % 2 == 1 ? Colors.grey.withOpacity(.05) : Colors.white,
                              title: Text(items[index].modelName,style: const TextStyle(fontWeight: FontWeight.bold),),
                              subtitle: Text(items[index].modelCode.toString()),

                            );
                          });
                    }
                  }),
            ),
          ],
        )
    );
  }
  _textTileDropDown(){
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      height: 40,

      child: DropdownSearch<TextTileModel>(
        popupProps: const PopupPropsMultiSelection.menu(
          fit: FlexFit.loose,
        ),
        asyncItems: (value) => db.getTextTile(),
        itemAsString: (TextTileModel u) => u.txtName.tr,
        onChanged: (TextTileModel? data) {
          setState(() {
            selectedCategoryId = data!.txtId!.toInt();
          });
        },

        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            border: InputBorder.none,
            hoverColor: Colors.transparent,
            contentPadding: const EdgeInsets.symmetric(horizontal: 5,vertical: 15),
            hintStyle: const TextStyle(fontSize: 15,fontFamily: "Dubai"),
            hintText: "text_tile".tr,
          ),
        ),
      ),
    );
  }

  _addModelForm(){
    Get.dialog(
      AlertDialog(
        title: Text("models".tr),
        content: SizedBox(
          width: MediaQuery.of(context).size.width *.4,
          height: Get.height *.8,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ZField(
                    icon: Icons.account_circle,
                    title: "model_name",
                    validator: (value){
                      if(value!.isEmpty){
                        return "model_name_required";
                      }
                      return null;
                    },
                    controller: modelName,
                    isRequire: true,
                    trailing: SizedBox(
                      width: 100,
                      child:  _textTileDropDown(),
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: ZField(
                          icon: Icons.qr_code_2,
                          title: "model_code",
                          validator: (value){
                            if(value!.isEmpty){
                              return "code_required";
                            }
                            return null;
                          },
                          controller: modelCode,
                          isRequire: true,
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: ZField(
                          icon: Icons.language,
                          title: "made_in".tr,
                          controller: madeIn,
                        ),
                      ),
                    ],
                  ),


                 const SizedBox(height: 15),
                  ListTile(leading: const Icon(Icons.line_axis_rounded), title: Text("line_details".tr)),
                 //Lines
                 Row(
                   children: [
                     Expanded(
                       child: ZField(
                         icon: Icons.line_axis_rounded,
                         title: "rasta_line".tr,
                         controller: rasta,
                       ),
                     ),

                     Expanded(
                       child: ZField(
                         icon: Icons.line_axis_rounded,
                         title: "zigzal_line".tr,
                         controller: zigzal,
                       ),
                     ),

                     Expanded(
                       child: ZField(
                         icon: Icons.line_axis_rounded,
                         title: "meyan_line".tr,
                         controller: meyan,
                       ),
                     ),
                   ],
                 ),

                  Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.photo),
                        title: Text("images".tr),
                      ),

                      IconButton(
                          onPressed: ()=> _pickFile(),
                          icon: const Icon(Icons.add))

                    ],
                  ),



                ],
              ),
            ),
          ),
        ),

        actions: [
          Row(
            children: [
              ZButton(
                width: .1,
                label: "cancel".tr,
                onTap: ()=>Get.back(),
              ),
              const SizedBox(width: 8),
              ZButton(
                width: .15,
                label: "create_model".tr,
                onTap: ()async{
                  if(formKey.currentState!.validate()){
                   var result = await db.createModel(
                        modelName.text,
                        modelCode.text,
                        selectedCategoryId,
                        madeIn.text,
                        rasta.text,
                        zigzal.text,
                        meyan.text,
                        DateTime.now().toIso8601String()).whenComplete(() {
                        Get.back();
                      _refresh();
                    });
                   if(result == 0){
                     Get.snackbar("duplicate_model".tr, "model_exist".tr,margin: const EdgeInsets.only(top: 15));
                   }
                  }
                },
              ),

            ],
          )
        ],
      ),
    );
  }

  _createModelButton(){
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
                      _addModelForm();
                    },
                    icon: Row(
                      children: [
                        Text("create_model".tr,style: const TextStyle(color: Colors.white),),
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
                    models = searchModel();
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

   void _pickFile()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if(result == null)return;
     file = result.files.single;

    if (kDebugMode) {
      print(file?.path??"");
    }

   }
}


