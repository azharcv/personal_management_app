

import 'package:flutter/material.dart';
import 'package:personal_management_app/db/category/category_db.dart';
import 'package:personal_management_app/screens/models/Category/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
      valueListenable: CategoryDb().incomeCategoryListNotifier,
       builder: (BuildContext, List<CategoryModel> categor_list, Widget? _) {
          return ListView.separated(
      itemBuilder:(context, index){
        final _category =categor_list[index];
         return Card(
           child: ListTile(
             title: Text(_category.name),
             trailing: IconButton(
               onPressed: (){
                 CategoryDb.instance.deleteCategory(_category.id);
               },
                icon: Icon(Icons.delete)),
         
           ),
         );
      },
      separatorBuilder: (ctx,index){
        return const SizedBox(height: 10);
      },
      itemCount: categor_list.length,
    );
       }

      
       
       );
  }
}