import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personal_management_app/db/category/transaction/transaction_model.dart';
import 'package:personal_management_app/screens/models/Category/category_model.dart';

const TRANSACTION_DB_NAME = 'transaction_database';

abstract class TransactionDbFunction {
  Future<void> addTransaction(TransactionModel obj);

  Future<List<TransactionModel>> getAllTransactions();

  Future<void> deleteTransaction(String id);
}

class TransactionDb implements TransactionDbFunction {
  TransactionDb._internal();

  static TransactionDb instance = TransactionDb._internal();

  factory TransactionDb() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _list = await getAllTransactions();
    _list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }

  @override
  Future<void> deleteTransaction(id) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.delete(id);
    refresh();
  }
}
