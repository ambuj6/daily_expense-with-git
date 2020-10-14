import '../models/transaction.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionsController extends GetxController {
  RxList<Transactions> userTransactions = List<Transactions>().obs;
  var showChart = false.obs;
  List<Transactions> get recentTransactions {
    return userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addTransaction(double txAmount, String txTitle, DateTime chosenDate) {
    final newTx = Transactions(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    userTransactions.add(newTx);
    //Get.updateLocale(userTransactions);
  }

  void deleteTransaction(String id) {
    userTransactions.removeWhere((tx) {
      return tx.id == id;
    });
  }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDays = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < userTransactions.length; i++) {
        if (userTransactions[i].date.day == weekDays.day &&
            userTransactions[i].date.month == weekDays.month &&
            userTransactions[i].date.year == weekDays.year) {
          totalSum += userTransactions[i].amount;
        }
      }
      return {
        "day": DateFormat.E().format(weekDays).substring(0, 1),
        "amount": totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum + element["amount"];
    });
  }
}
