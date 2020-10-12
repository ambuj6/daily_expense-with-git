import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './widgets/transactions_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
import 'controller/transactions_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    return MaterialApp(
        home: HomePage(),
        title: "Daily Expenses",
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
        ));
  }
}

class HomePage extends StatelessWidget {
  final TransactionsController c = Get.put(TransactionsController());

  bool showChart = false;
  void startAddNewTransation(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(c.addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(title: Text("Daily Expenses"), actions: [
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          startAddNewTransation(context);
        },
      ),
    ]);
    final txListWidget = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.75,
        child: TransactionList(c.userTransactions, c.deleteTransaction));
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                if (isLandScape)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Show Chart"),
                      Switch(
                        value: showChart,
                        onChanged: (val) {
                          showChart = val;
                        },
                      ),
                    ],
                  ),
                if (!isLandScape)
                  Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.25,
                    child: Chart(c.recentTransactions),
                  ),
                if (!isLandScape) txListWidget,
                if (isLandScape)
                  showChart
                      ? Container(
                          height: (MediaQuery.of(context).size.height -
                                  appBar.preferredSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.7,
                          child: Chart(c.recentTransactions))
                      : txListWidget
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          startAddNewTransation(context);
        },
      ),
    );
  }
}
