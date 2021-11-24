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

  List<TaskModel> liste = [];
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    //Hive.registerAdapter(TaskModelAdapter());
    todoBox = Hive.box<TaskModel>(ApplicationConstants.TASKBOX_NAME);
    print(liste.length.toString());
    //liste = todoBox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: _buildAppbar,

        body: Container(
          color: Colors.amber,
          height: 500,
          child: Column(
            children: <Widget>[
              ValueListenableBuilder(
                valueListenable: todoBox.listenable(),
                builder: (context, Box<TaskModel> liste, _) {
                  print(liste.length.toString());
                  List<int> keys;
                  keys = liste.keys.cast<int>().toList();
                  
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: liste.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      //final TaskModel todo = todos.get(key)!;
                      final int key = keys[index];
                      // final Box<TaskModel> data = liste.get(key);
                      return Text('data ${liste.get(key)?.detail}');
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
