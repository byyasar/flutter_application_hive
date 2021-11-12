import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/model/task_model.dart';
import 'package:flutter_application_hive/view/todo_filter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainpageView extends StatefulWidget {
  const MainpageView({Key? key}) : super(key: key);

  @override
  _MainpageViewState createState() => _MainpageViewState();
}

late Box<TaskModel> todoBox;
final TextEditingController titleController = TextEditingController();
final TextEditingController detailController = TextEditingController();

class _MainpageViewState extends State<MainpageView> {
  TodoFilter filter = TodoFilter.ALL;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoBox = Hive.box<TaskModel>(ApplicationConstants.TASKBOX_NAME);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: _buildAppbar,
        floatingActionButton: _buildFloatinActionButton(context),
        body: Container(
          color: Colors.amber,
          height: 500,
          child: Column(
            children: <Widget>[
              ValueListenableBuilder(
                valueListenable: todoBox.listenable(),
                builder: (context, Box<TaskModel> todos, _) {
                  List<int> keys;

                  if (filter == TodoFilter.ALL) {
                    keys = todos.keys.cast<int>().toList();
                  } else if (filter == TodoFilter.COMPLETED) {
                    keys = todos.keys
                        .cast<int>()
                        .where((key) => todos.get(key)!.isCompleted)
                        .toList();
                  } else {
                    keys = todos.keys
                        .cast<int>()
                        .where((key) => !todos.get(key)!.isCompleted)
                        .toList();
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: keys.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      //final int key = keys[index];
                      //final TaskModel todo = todos.get(key)!;
                      return Text('data $index');
                    },
                  );
                },
              )
            ],
          ),
        ),

        /*floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                child: Dialog(
                    child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(hintText: "Title"),
                        controller: titleController,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        decoration: InputDecoration(hintText: "Detail"),
                        controller: detailController,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      FlatButton(
                        child: Text("Add Todo"),
                        onPressed: () {
                          ///Todo : Add Todo in hive
                          final String title = titleController.text;
                          final String detail = detailController.text;

                          TaskModel todo = TaskModel(
                              title: title, detail: detail, isCompleted: false);

                          todoBox.add(todo);

                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                )),
                builder: (BuildContext context) {});
          },
          child: Icon(Icons.add),
        ), */ // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  AppBar get _buildAppbar {
    return AppBar(
      title: const Text('Hive Todo App'),
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value.compareTo("All") == 0) {
              setState(() {
                filter = TodoFilter.ALL;
              });
            } else if (value.compareTo("Compeleted") == 0) {
              setState(() {
                filter = TodoFilter.COMPLETED;
              });
            } else {
              setState(() {
                filter = TodoFilter.INCOMPLETED;
              });
            }
          },
          itemBuilder: (BuildContext context) {
            return ["Hepsi", "Tamamlananlar", "Yapılacaklar"].map((option) {
              return PopupMenuItem(
                value: option,
                child: Text(option),
              );
            }).toList();
          },
        )
      ],
    );
  }
}

FloatingActionButton _buildFloatinActionButton(BuildContext context) {
  return FloatingActionButton(onPressed: () {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog();
        });
  });
}
