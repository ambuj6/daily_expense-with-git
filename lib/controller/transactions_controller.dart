import '../models/transaction.dart';
import 'package:get/get.dart';

class TransactionsController {
  final RxList<dynamic> userTransactions = [].obs;

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
  }

  void deleteTransaction(String id) {
    userTransactions.removeWhere((tx) {
      return tx.id == id;
    });
  }
}
