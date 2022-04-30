import 'package:flutter/material.dart';
import 'package:personal_management_app/db/category/category_db.dart';
import 'package:personal_management_app/screens/category/expense_category_list.dart';
import 'package:personal_management_app/screens/category/income_category_list.dart';

class ScreenCategory  extends StatefulWidget {
  const ScreenCategory({ Key? key }) : super(key: key);

  @override
  State<ScreenCategory> createState() => _State();
}

class _State extends State<ScreenCategory> with SingleTickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().refreshUI();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      TabBar(
        controller: _tabController,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        tabs: [
        Tab(text: 'INCOME'),
        Tab(text: 'EXPENSE')]
        ),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
            IncomeCategoryList(),
             ExpenseCategoryList(),
        
          ]),
        )
    ],
      
    );
  }
} 