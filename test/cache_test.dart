import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/model/task_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

void main() {
  setUp(() {
    Hive.init('database');
  });
  test('Name Box Create and Put', () async {
    final box = await Hive.openBox<String>('hwa');
    await box.add('veli');
    expect(box.values.first, 'veli');
  });

  test('Name Box Create and Put', () async {
    final themaBox = await Hive.openBox<bool>('theme');
    await themaBox.put('theme', true);

    expect(themaBox.get('theme'), true);
  });

  test('Name Box Add List', () async {
    final box = await Hive.openBox<String>('hwa');
    await box.clear();
    List<String> items = List.generate(100, (index) => '$index');
    await box.addAll(items);

    expect(box.values.first, '0');
  });

  test('Name Box Put Items', () async {
    final box = await Hive.openBox<String>('demos');

    List<MapEntry<String, String>> items = List.generate(
        100, (index) => MapEntry('$index - $index', 'veli $index'));
    await box.putAll(Map.fromEntries(items));

    expect(box.get('99 - 99'), 'veli 99');
  });

  test('model kaydetme', () async {
    Hive.registerAdapter(TaskModelAdapter());
    final box =
        await Hive.openBox<TaskModel>(ApplicationConstants.taskBoxName);
    box.clear();
    TaskModel mData1 =
        TaskModel(title: 'data.title1', detail: 'data.1', isCompleted: false);
    TaskModel mData2 =
        TaskModel(title: 'data.title2', detail: 'data.2', isCompleted: false);
    TaskModel mData3 =
        TaskModel(title: 'data.title3', detail: 'data.3', isCompleted: false);
    box.put(1, mData1);
    box.put(2, mData2);
    box.put(3, mData3);
    expect(box.length, 3);
    //box.close();
  });

  test('modelleri listeleme', () async {
    Hive.registerAdapter(TaskModelAdapter());
    final box =
        await Hive.openBox<TaskModel>(ApplicationConstants.taskBoxName);
    // ignore: avoid_print
    print(box.keys);
    for (var item in box.values) {
      // ignore: avoid_print
      print(item);
    }

    expect(box.length, 3);
  });
}
