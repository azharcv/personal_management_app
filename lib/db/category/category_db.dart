import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personal_management_app/screens/models/Category/category_model.dart';

const CATEGORY_DB_NAME = 'category_database';

abstract class CategoryDbFunction {
  Future<List<CategoryModel>> getCategories();

  Future<void> insertCategory(CategoryModel values);

  Future<void>deleteCategory(String categoryId);
}

class CategoryDb implements CategoryDbFunction {

  CategoryDb._internal();
  static CategoryDb instance = CategoryDb._internal();

  factory CategoryDb(){
    return instance;
  }


  ValueNotifier<List<CategoryModel>> incomeCategoryListNotifier =ValueNotifier([]);

  ValueNotifier<List<CategoryModel>> expenseCategoryListNotifier =ValueNotifier([]);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.put(value.id,value);
    refreshUI();
  }

  Future<void>refreshUI()async{
    final _allcategories =  await getCategories();
    incomeCategoryListNotifier.value.clear();
    expenseCategoryListNotifier.value.clear();
    //asynchromus
   await  Future.forEach(
      _allcategories, 
      (CategoryModel category) {
          if(category.type==CategoryType.income){
            incomeCategoryListNotifier.value.add(category);
          }else{
            expenseCategoryListNotifier.value.add(category);
          }
      });
      incomeCategoryListNotifier.notifyListeners();
      expenseCategoryListNotifier.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryId)  async{
    final _categoryDb =await  Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    _categoryDb.delete(categoryId);
    refreshUI();
  }
}
