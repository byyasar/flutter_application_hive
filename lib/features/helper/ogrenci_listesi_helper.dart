import 'package:flutter_application_hive/features/helper/liste_helper_interface.dart';
import 'package:hive/hive.dart';

class OgrenciListesiHelper extends IListeHelper {
  OgrenciListesiHelper(String key) : super(key);

  @override
  List? getFilteredValues(String filtreKey, int filtreValue) {
    // TODO: implement getFilteredValues
    throw UnimplementedError();
  }

  @override
  getItem(String key, Box? _box) {
    // TODO: implement getItem
    throw UnimplementedError();
  }

  @override
  List? getValues() {
    // TODO: implement getValues
    throw UnimplementedError();
  }

  @override
  void registerAdapters() {
    // TODO: implement registerAdapters
  }
}
