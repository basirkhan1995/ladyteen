import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladyteen_system/Components/Colors/colors.dart';
import 'package:ladyteen_system/Views/Accounts/Screens/accounts.dart';
import 'package:ladyteen_system/Views/Accounts/accounts_view.dart';
import 'package:ladyteen_system/Views/Cuttings/cuttings.dart';
import 'package:ladyteen_system/Views/Home/dashboard.dart';
import 'package:ladyteen_system/Views/Models/models.dart';
import 'package:ladyteen_system/Views/Reports/general_reports.dart';
import 'package:ladyteen_system/Views/Settings/settings.dart';

import '../../Components/Getx/getx_settings.dart';
import '../../Components/Methods/responsive_screen.dart';

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
    "reports".tr,
    "settings".tr
  ];

  List menuIcon = [
    Icons.pie_chart,
    Icons.access_time_filled_outlined,
    Icons.color_lens,
    Icons.account_circle,
    Icons.bar_chart_rounded,
    Icons.settings
  ];

  List routes = [
    const Dashboard(),
    const Cuttings(),
    const Models(),
    const AccountsView(),
    const GeneralReports(),
    const Settings(),
  ];

  int selectedIndex = 0;
  bool selectedItem = false;
  final controller = Get.put(GetxSettings());
  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
        mobile: businessHomeMobile(),
        tablet: businessHomeTablet(),
        desktop: businessHomeDesktop());
  }

  Widget businessHomeMobile() {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                DrawerHeader(
                  child: Image.asset("assets/photos/ladyteen.png"),
                ),

                Expanded(
                    child: ListView.builder(
                        itemCount: menuTitle.length,
                        itemBuilder: (context, index) {
                          selectedItem = selectedIndex == index;
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: selectedItem ? primaryColor : Colors.transparent),
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  Get.to(routes[selectedIndex]);
                                });
                              },
                              horizontalTitleGap: 4,
                              leading: Icon(menuIcon[index],
                                  size: selectedItem ? 22 : 20,
                                  color: selectedItem ? Colors.white : primaryColor),
                              title: Text(menuTitle[index],
                                  style: TextStyle(
                                      fontSize: selectedItem ? 15 : 13,
                                      fontWeight: selectedItem
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: selectedItem ? Colors.white : primaryColor)),
                            ),
                          );
                        })),

                //End
                const ListTile(
                  title: Text("Basir Hashimi"),
                  subtitle: Text("Admin"),
                  leading: CircleAvatar(
                    radius: 27,
                    backgroundColor: primaryColor,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/photos/ladyteen.png"),
                      radius: 26,
                    ),
                  ),
                )
              ],
            ),
          )),
      appBar: AppBar(
        title: const Text("Personal Home Mobile"),
      ),
    );
  }

  Widget businessHomeTablet() {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(
                child: Image.asset("assets/photos/ladyteen.png"),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: menuTitle.length,
                      itemBuilder: (context, index) {
                        selectedItem = selectedIndex == index;
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: selectedItem ? primaryColor : Colors.transparent),
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                Get.to(()=>routes[selectedIndex]);
                              });
                            },
                            horizontalTitleGap: 2,
                            leading: Icon(menuIcon[index],
                                size: selectedItem ? 24 : 22,
                                color: selectedItem ? Colors.white : primaryColor),
                            title: Text(menuTitle[index],
                                style: TextStyle(
                                    fontSize: selectedItem ? 17 : 15,
                                    fontWeight: selectedItem
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color:
                                    selectedItem ? Colors.white : primaryColor)),
                          ),
                        );
                      })),
              //End
              const ListTile(
                title: Text("Basir Hashimi"),
                subtitle: Text("Admin"),
                leading: CircleAvatar(
                  radius: 27,
                  backgroundColor: primaryColor,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/photos/ladyteen.png"),
                    radius: 26,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Personal Home Tablet"),
      ),
    );
  }

  Widget businessHomeDesktop() {

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
              width: 220,
              child: Column(
                children: [
                  DrawerHeader(
                    child: Image.asset("assets/photos/ladyteen.png"),
                  ),
                  Expanded(
                      flex: 3,
                      child: ListView.builder(
                          itemCount: menuTitle.length,
                          itemBuilder: (context, index) {
                            selectedItem = selectedIndex == index;
                            return Container(
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
                                title: Text(menuTitle[index],
                                    style: TextStyle(
                                        fontSize: selectedItem ? 15 : 13,
                                        fontWeight: selectedItem
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: selectedItem
                                            ? Colors.white
                                            : primaryColor)),
                              ),
                            );
                          })),
                  //End
                  const ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    title: Text("بصیر هاشمی",style: TextStyle(fontSize:14,fontWeight: FontWeight.bold),),
                    subtitle: Text("مدیر"),

                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/photos/ladyteen.png"),
                      radius: 20,
                    ),
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
