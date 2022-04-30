import 'package:flutter/material.dart';
import 'package:personal_management_app/db/category/category_db.dart';
import 'package:personal_management_app/screens/models/Category/category_model.dart';

ValueNotifier<CategoryType>selectedCatewgoryNotifier = ValueNotifier(CategoryType.income);
Future<void> showCategoryPopUp(BuildContext context) async {
 final _nameEditingController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Text('Add Category'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RadioButton(title: 'Income', type: CategoryType.income),
                  RadioButton(title: 'Expense', type: CategoryType.expense),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                final _name = _nameEditingController.text;
                if(_name.isEmpty){
                  return;
                }
                final _type = selectedCatewgoryNotifier.value;
               final _category = CategoryModel(
                 id: DateTime.now().millisecondsSinceEpoch.toString(),
                 name: _name,
                 type: _type);
                 CategoryDb().insertCategory(_category);
                 Navigator.of(ctx).pop();
              },
              child: Text('Add Cateopry'),
            ),
          ),
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

 RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

 
  CategoryType? _type;
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          ValueListenableBuilder(
          
            valueListenable: selectedCatewgoryNotifier,
             builder:(BuildContext ctx, CategoryType newCategory,_){
  
            return Radio<CategoryType>(
              value: type,
              groupValue: newCategory,
              onChanged: (value) {
                if(value==null){
                  return;
                }
                  selectedCatewgoryNotifier.value = value;
                  selectedCatewgoryNotifier.notifyListeners();
              }
  );
             },
           ),
          
          Text(title),
        ],
    );
  }
}
