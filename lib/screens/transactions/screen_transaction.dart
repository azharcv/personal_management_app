import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:personal_management_app/db/category/category_db.dart';
import 'package:personal_management_app/db/category/transaction/transaction_model.dart';
import 'package:personal_management_app/db/category/transaction_db.dart';
import 'package:personal_management_app/screens/models/Category/category_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryDb.instance.refreshUI();
    TransactionDb.instance.refresh();
    return ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactionListNotifier,
        builder: (BuildContext ctx, List<TransactionModel> newLIst, Widget? _) {
          return ListView.separated(
              padding: EdgeInsets.all(10),
              itemBuilder: (ctx, index) {
                final _value = newLIst[index];
                return Slidable(
                  key: Key(_value.id!),
                  startActionPane: ActionPane(
                    motion: ScrollMotion(),
                     children: [SlidableAction(
                       icon: Icons.delete,
                       label: 'Delete',
                       onPressed: (ctx){
                          TransactionDb.instance.deleteTransaction(_value.id!);
                     })]),
                  child: Card(
                    elevation: 0,
                    child: ListTile(
                      leading: CircleAvatar(
                          backgroundColor: _value.type == CategoryType.income
                              ? Colors.green
                              : Colors.red,
                          radius: 50,
                          child: Text(parseDate(_value.date),
                              textAlign: TextAlign.center)),
                      title: Text('RS ${_value.amount}'),
                      subtitle: Text(_value.category.name),
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(height: 10);
              },
              itemCount: newLIst.length);
        });
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _spilit_date = _date.split(' ');
    return '${_spilit_date.first}\n${_spilit_date.last}';
    // return '${date.day}\n${date.month}';
  }
}
