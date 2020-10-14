import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expenses/models/transaction.dart';
import './../controller/transactions_controller.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> userTransactions;
  TransactionList(this.userTransactions);
  final c = Get.find<TransactionsController>();

  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? Column(
            children: [
              Text("No transaction added yet"),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Expanded(
                  child: Image.asset(
                    'images/waterfall.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: FittedBox(
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Text('\$${userTransactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    userTransactions[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(userTransactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width >= 400
                      ? FlatButton.icon(
                          onPressed: () =>
                              c.deleteTransaction(userTransactions[index].id),
                          icon: Icon(Icons.delete),
                          label: Text("Delete"),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              c.deleteTransaction(userTransactions[index].id),
                        ),
                ),
              );
            },
            itemCount: userTransactions.length,
          );
  }
}
