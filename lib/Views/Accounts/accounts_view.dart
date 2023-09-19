import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladyteen_system/Views/Accounts/Screens/accounts_report.dart';
import '../../Components/Colors/colors.dart';
import 'Screens/accounts.dart';



class AccountsView extends StatefulWidget {
  const AccountsView({super.key});

  @override
  State<AccountsView> createState() => _AccountsViewState();
}

class _AccountsViewState extends State<AccountsView> {

  final _tabPages = [
    const Accounts(),
    const AccountsReport(),
  ];

  final _tabs = <Widget>[
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Tab(
          text: "accounts".tr
      ),
    ),

    Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Tab(
          text: "accounts_report".tr,
        )),

  ];

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("accounts".tr),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TabBar(
                    splashBorderRadius: BorderRadius.circular(8),
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    labelPadding: const EdgeInsets.only( left: 0, right: 0, top: 0),
                    isScrollable: true,
                    unselectedLabelColor: Colors.grey,
                    automaticIndicatorColorAdjustment: true,
                    indicatorWeight: 2,

                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: primaryColor,
                    indicatorColor: primaryColor,
                    tabs: _tabs),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: _tabPages,
        ),
      ),
    );
}
}
