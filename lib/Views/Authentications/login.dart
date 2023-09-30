import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladyteen_system/Components/Colors/colors.dart';
import 'package:ladyteen_system/Components/Methods/button.dart';
import 'package:ladyteen_system/Components/Methods/textfield.dart';
import 'package:ladyteen_system/JsonModels/user_model.dart';
import 'package:ladyteen_system/Views/Home/start_screen.dart';

import '../../SQLite/database_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final username = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool rememberMe = false;
  bool isVisible = false;
  bool isLoginTrue = false;

  final db = DatabaseHelper();
  login()async{
    var res = await db.authenticateUser(UsersModel(usrName: username.text, usrPassword: password.text));
    if(res == true){
      Get.off(()=>const HomeScreen());
    }else{
      setState(() {
        isLoginTrue = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: Get.width *.4,
              margin: const EdgeInsets.all(12),
              height: double.infinity,
              decoration: BoxDecoration(
                  color: primaryColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("welcome".tr,style: TextStyle(fontSize: Get.width/25,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 25),
                      Image.asset("assets/photos/login.png",width: Get.width/5),
                      const SizedBox(height: 25),
                      Text("ladyteen".tr,style: TextStyle(fontSize: Get.width/25,fontWeight: FontWeight.bold),),
                      Text("ladyteen_slogan".tr,style: TextStyle(fontSize: Get.width/35,color: primaryColor),),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      Container(
                        padding: const EdgeInsets.all(35),
                        width: 450,
                        height: Get.height *.9,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 1,
                              )
                            ]
                        ),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: Get.width *.15,
                                    child: Image.asset("assets/photos/login.png")),

                                const SizedBox(height: 35),

                                ZField(
                                  title: "username".tr,
                                  controller: username,
                                  icon: Icons.account_circle,
                                  validator: (value){
                                    if(value.isEmpty){
                                      return "username_required".tr;
                                    }
                                    return null;
                                  },
                                ),

                                ZField(
                                  title: "password".tr,
                                  controller: password,
                                  icon: Icons.lock,
                                  securePassword: !isVisible,
                                  validator: (value){
                                    if(value.isEmpty){
                                      return "password_required".tr;
                                    }
                                    return null;
                                  },
                                  trailing: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        isVisible = !isVisible;
                                      });
                                    },
                                    icon: Icon(isVisible? Icons.visibility :Icons.visibility_off),
                                  ),
                                ),


                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                                  horizontalTitleGap: 4,
                                  title: Text("remember_me".tr),
                                  leading: Checkbox(
                                    value: rememberMe,
                                    onChanged: (value){
                                      setState(() {
                                        rememberMe = !rememberMe;
                                      });
                                    },
                                  ),
                                  trailing: Text("forgot_password".tr),
                                ),


                                const SizedBox(height: 10),
                                ZButton(
                                  label: "login".tr,
                                  onTap: (){
                                    if(formKey.currentState!.validate()){
                                      login();
                                    }else{
                                      Get.snackbar("validation".tr, "validation_message".tr,margin: const EdgeInsets.all(10));
                                    }
                                  },
                                ),
                                const SizedBox(height: 15),

                                isLoginTrue? Text("access_denied_auth".tr,style: TextStyle(color: Colors.red.shade900),):const SizedBox(),

                              ],
                            ),
                          ),
                        ),
                      )


                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
