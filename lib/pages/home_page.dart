import 'dart:ffi';

import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseRupeeController = TextEditingController();
  final newExpenseCentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Provider.of<ExpenseData>(context, listen: false).prepreData();
  }

  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Add New Expense'),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                TextField(
                  controller: newExpenseNameController,
                  decoration: const InputDecoration(
                    hintText: "Expense Name",
                  ),
                ),
                Row(
                  children: [
                    //Rupee
                    Expanded(
                      child: TextField(
                        controller: newExpenseRupeeController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Rs",
                        ),
                      ),
                    ),

                    //Cent
                    Expanded(
                      child: TextField(
                        controller: newExpenseCentController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Cents",
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
              actions: [
                MaterialButton(
                  onPressed: save,
                  child: Text('Save'),
                ),
                MaterialButton(
                  onPressed: save,
                  child: Text('Cancel'),
                ),
              ],
            ));
  }

  //Save Method
  void save() {
    //Set Rupees and Dollers together
    String amount =
        '${newExpenseRupeeController.text}.${newExpenseCentController.text}';

    //create expense item
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: amount,
      dateTime: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

    Navigator.pop(context);
    clear();
  }

  //cancel method
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  //clear controllers
  void clear() {
    newExpenseNameController.clear();
    newExpenseRupeeController.clear();
    newExpenseCentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            child: Icon(Icons.add),
          ),
          body: ListView(
            children: [
              //weekly summary
              ExpenseSummary(
                startOfWeek: value.startOfWeekDate(),
              ),
              //expense list
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.getAllExpenseList().length,
                  itemBuilder: (context, index) => ExpenseTile(
                      name: value.getAllExpenseList()[index].name,
                      amount: value.getAllExpenseList()[index].amount,
                      dateTime: value.getAllExpenseList()[index].dateTime)),
            ],
          )),
    );
  }
}
