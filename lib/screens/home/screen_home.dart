import 'package:flutter/material.dart';
import 'package:personal_management_app/add_transaction/screen_add_transaction.dart';
import 'package:personal_management_app/db/category/category_db.dart';
import 'package:personal_management_app/screens/category/category_add_popup.dart';
import 'package:personal_management_app/screens/category/screen_category.dart';
import 'package:personal_management_app/screens/home/widget/bottom_navigation.dart';
import 'package:personal_management_app/screens/models/Category/category_model.dart';
import 'package:personal_management_app/screens/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [
    ScreenTransaction(),
    ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Money Manager'),
        centerTitle: true,
        ),
      bottomNavigationBar: const MoneyMangaerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: selectedIndexNotifier,
            builder: (BuildContext context, int updatedindex, _) {
              return _pages[updatedindex];
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print('Add TRANSACTION');
            Navigator.of(context).pushNamed(ScreenAddTransaction.routName);
          }else{
            print('Add Category');
            // final _sample=CategoryModel(id: DateTime.now().millisecondsSinceEpoch.toString(),name:'Travel' ,isDeleted:false,type: CategoryType.expense);
          
          // CategoryDb().insertCategory(_sample);
          showCategoryPopUp(context);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
