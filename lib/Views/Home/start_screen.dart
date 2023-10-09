import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladyteen_system/Components/Colors/colors.dart';
import 'package:ladyteen_system/Views/Accounts/Screens/accounts.dart';
import 'package:ladyteen_system/Views/Cuttings/cuttings.dart';
import 'package:ladyteen_system/Views/Home/dashboard.dart';
import 'package:ladyteen_system/Views/Models/models.dart';
import 'package:ladyteen_system/Views/Reports/general_reports.dart';
import 'package:ladyteen_system/Views/Settings/settings.dart';
import 'package:ladyteen_system/Views/transactions/transactions.dart';
import '../../Components/Getx/getx_settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List menuTitle = [
    "dashboard".tr,
    "cuttings".tr,
    "models".tr,
    "accounts".tr,
    "transactions".tr,
    "reports".tr,
    "settings".tr
  ];

  List menuIcon = [
    Icons.pie_chart,
    Icons.access_time_filled_outlined,
    Icons.color_lens,
    Icons.account_circle,
    Icons.ssid_chart,
    Icons.bar_chart_rounded,
    Icons.settings
  ];

  List routes = [
    const Dashboard(),
    const Cuttings(),
    const Models(),
    const Accounts(),
    const Transactions(),
    const GeneralReports(),
    const Settings(),
  ];

  int selectedIndex = 0;
  bool selectedItem = false;

  bool isExpanded = false;

  double minWidth = 80;
  double maxWidth = 220;
  final controller = Get.put(GetxSettings());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Row(
          children: [
            //Menu
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  color: Colors.white),
              width: isExpanded? minWidth : maxWidth,
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: DrawerHeader(
                      child: Image.asset("assets/photos/ladyteen.png"),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: ListView.builder(
                          itemCount: menuTitle.length,
                          itemBuilder: (context, index) {
                            selectedItem = selectedIndex == index;
                            return Container(
                              padding: EdgeInsets.zero,
                              margin:
                              const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: selectedItem
                                      ? primaryColor
                                      : Colors.transparent),
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                   selectedIndex = index;
                                  });
                                },
                                horizontalTitleGap: 8,
                                leading: Icon(menuIcon[index],
                                    size: selectedItem ? 22 : 20,
                                    color:
                                    selectedItem ? Colors.white : primaryColor),
                                title: !isExpanded? Text(menuTitle[index],
                                    style: TextStyle(
                                        fontSize: selectedItem ? 15 : 13,
                                        fontWeight: selectedItem
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: selectedItem
                                            ? Colors.white
                                            : primaryColor)): null,
                              ),
                            );
                          })),
                  //End
                   ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    title: !isExpanded? Text("بصیر هاشمی",style: TextStyle(fontSize:14,fontWeight: FontWeight.bold),):null,
                    subtitle: !isExpanded? Text("مدیر"):null,

                    leading: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.logout))
                  )
                ],
              ),
            ),

            //Body
            Expanded(
                flex: 5,
                child: Container(
                  color: Colors.white,
                  child: routes[selectedIndex],
                ))
          ],
        ),
      ),
    );
  }

}
