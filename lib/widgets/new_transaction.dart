import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import './../controller/transactions_controller.dart';

class NewTransaction extends StatefulWidget {
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final c = Get.find<TransactionsController>();
  final titalController = TextEditingController();
  final amountController = TextEditingController();

  DateTime _selectedDate;

  void submitData(BuildContext context) {
    final enteredAmount = double.parse(amountController.text);
    final enteredTital = titalController.text;

    if (enteredAmount <= 0 || enteredTital.isEmpty || _selectedDate == null) {
      return;
    }
    c.addTransaction(
      enteredAmount,
      enteredTital,
      _selectedDate,
    );
    Navigator.of(context).pop();
    print(c.userTransactions);
  }

  void datePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titalController,
              onSubmitted: (_) => submitData(context),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(context),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null
                        ? "No Date chosen"
                        : 'Picked Date  ${DateFormat.yMMMd().format(_selectedDate)}'),
                  ),
                  FlatButton(
                    child: Text(
                      "Choose Date",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () => datePicker(context),
                  ),
                ],
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                "Add Transation",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => submitData(context),
            ),
          ],
        ),
      ),
    );
  }
}
