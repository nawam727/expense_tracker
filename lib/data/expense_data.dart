import 'package:expense_tracker/models/expense_item.dart';

class ExpenseData {
  // All expense list
  List<ExpenseItem> overallExpenseList = [];

  //Get expense list here
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  //Add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
  }

  //Delete added expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
  }

  //Get weekdays (mon, tue, ect) from a dateTime object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // Get the date for the start of the week (Monday)
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    //Get today's date
    DateTime today = DateTime.now();

    //Go backwards from to find Monday
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Mon') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }

    return startOfWeek!;
  }
}
