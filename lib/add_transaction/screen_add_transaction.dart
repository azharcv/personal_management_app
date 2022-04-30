import 'package:flutter/material.dart';
import 'package:personal_management_app/db/category/category_db.dart';
import 'package:personal_management_app/db/category/transaction/transaction_model.dart';
import 'package:personal_management_app/db/category/transaction_db.dart';
import 'package:personal_management_app/screens/models/Category/category_model.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routName = 'add-transaction';
  const ScreenAddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  /*
  Purpose
  date
  amount
  income/expense
  categorytype
  */
  String? _categoryId;
  DateTime? _selectDate;
  CategoryType? _selectCategoryType;
  CategoryModel? _selectCategoryModel;

  final _purposeTextEditingController = TextEditingController();

  final _purposeAmountEditingController = TextEditingController();

  @override
  void initState() {
    _selectCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //purpose
            TextFormField(
              controller: _purposeTextEditingController,
              decoration: InputDecoration(
                hintText: 'Purpose',
              ),
            ),
            //amount
            TextFormField(
              controller: _purposeAmountEditingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Amount',
              ),
            ),
            //date
            TextButton.icon(
              onPressed: () async {
                final _selctDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    lastDate: DateTime.now());
                if (_selctDateTemp == null) {
                  return;
                } else {
                  print(_selctDateTemp.toString());
                  setState(() {
                    _selectDate = _selctDateTemp;
                  });
                }
              },
              icon: Icon(Icons.calendar_today),
              label: Text(_selectDate == null
                  ? 'Select Date'
                  : _selectDate!.toString()),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                        value: CategoryType.income,
                        groupValue: _selectCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectCategoryType = CategoryType.income;
                            _categoryId = null;
                          });
                        }),
                    Text('income'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: CategoryType.expense,
                        groupValue: _selectCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectCategoryType = CategoryType.expense;
                            _categoryId = null;
                          });
                        }),
                    Text('expense'),
                  ],
                ),
              ],
            ),

            DropdownButton<String>(
                hint: const Text('Select Category'),
                value: _categoryId,
                items: (_selectCategoryType == CategoryType.income
                        ? CategoryDb.instance.incomeCategoryListNotifier
                        : CategoryDb.instance.expenseCategoryListNotifier)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id, 
                    child: Text(e.name),
                    onTap: (){
                      print(e.toString());
                      _selectCategoryModel = e;
                    },
                    );
                }).toList(),
                onChanged: (selectedValue) {
                  setState(() {
                    _categoryId = selectedValue;
                  });
                  print(selectedValue);
                }),
            ElevatedButton(
              onPressed: () {
                addTransaction();
              },
              child: Text('Submit'),
            )
          ],
        ),
      )),
    );
  }

  Future<void> addTransaction() async {
    final _puposeText = _purposeTextEditingController.text;
    final _amountText = _purposeAmountEditingController.text;
    if (_puposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    //_selectDate
    //_selectedcategorytype
    if (_selectCategoryModel == null) {
      return;
    }

    if (_selectDate == null) {
      return;
    }

    final paresedAmount = double.tryParse(_amountText);
    if(paresedAmount == null){
      return;
    }

   final _model=  TransactionModel(
      purpose: _puposeText,
      amount: paresedAmount,
      date: _selectDate!,
      type: _selectCategoryType!,
      category: _selectCategoryModel!,
    );
  await  TransactionDb.instance.addTransaction(_model);
  Navigator.of(context).pop();
  TransactionDb.instance.refresh();
  }
}
