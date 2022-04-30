import 'package:flutter/material.dart';
import 'package:personal_management_app/db/category/category_db.dart';
import 'package:personal_management_app/screens/models/Category/category_model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().expenseCategoryListNotifier,
      builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
        return ListView.separated(
          itemBuilder: (context, index) {
            final _category = newList[index];
            return Card(
              child: ListTile(
                title: Text(_category.name),
                trailing:
                    IconButton(onPressed: () {
                      CategoryDb.instance.deleteCategory(_category.id);
                    }, icon: Icon(Icons.delete)),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return const SizedBox(height: 10);
          },
          itemCount: newList.length,
        );
      },
    );
  }
}
