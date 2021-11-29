import 'package:flutter/material.dart';
import 'package:flutter_application_hive/model/task_model.dart';
import 'package:flutter_application_hive/transaction_dialog.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainpageView extends StatefulWidget {
  const MainpageView({Key? key}) : super(key: key);

  @override
  _MainpageViewState createState() => _MainpageViewState();
}

class _MainpageViewState extends State<MainpageView> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  void editTransaction(
    TaskModel transaction,
    String title,
    String detail,
    bool isCompleted,
  ) {
    transaction.title = title;
    transaction.detail = detail;
    transaction.isCompleted = isCompleted;
    transaction.save();
  }

  void deleteTransaction(TaskModel transaction) {
    // final box = Boxes.getTransactions();
    // box.delete(transaction.key);

    transaction.delete();
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Hive Expense Tracker'),
          centerTitle: true,
        ),
        body: ValueListenableBuilder<Box<TaskModel>>(
          valueListenable: Boxes.getTransactions().listenable(),
          builder: (context, box, _) {
            final transactions = box.values.toList().cast<TaskModel>();
            // ignore: avoid_print
            print(transactions.length);
            //return Text(transactions[1].detail);
            return buildContent(transactions);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => TransactionDialog(
              onClickedDone: addTransaction,
            ),
          ),
        ),
      );

  Widget buildContent(List<TaskModel> transactions) {
    if (transactions.isEmpty) {
      return const Center(
        child: Text(
          'No expenses yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      //return Text(transactions.length.toString());
      return Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                final transaction = transactions[index];

                return buildTransaction(context, transaction);
                //return Text(transactions.length.toString());
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      );
    }
  }

  Widget buildTransaction(
    BuildContext context,
    TaskModel transaction,
  ) {
//DateFormat.yMMMd().format(transaction.createdDate);
    //final amount = '\$' + transaction.amount.toStringAsFixed(2);

    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          transaction.title,
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(transaction.detail),
        trailing:
            Checkbox(value: transaction.isCompleted, onChanged: (onChanged) {}),
        children: [
          buildButtons(context, transaction),
        ],
      ),
    );
  }

  Future addTransaction(String title, String detail, bool isCompleted) async {
    final transaction =
        TaskModel(title: title, detail: detail, isCompleted: isCompleted);

    final box = Boxes.getTransactions();
    box.add(transaction);
    //box.put('mykey', transaction);

    // final mybox = Boxes.getTransactions();
    // final myTransaction = mybox.get('key');
    // mybox.values;
    // mybox.keys;
  }

  Widget buildButtons(BuildContext context, TaskModel transaction) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: const Text('Edit'),
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TransactionDialog(
                    transaction: transaction,
                    onClickedDone: (title, detail, isCompleted) =>
                        editTransaction(
                            transaction, title, detail, isCompleted),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: const Text('Delete'),
              icon: const Icon(Icons.delete),
              onPressed: () => deleteTransaction(transaction),
            ),
          )
        ],
      );
}
