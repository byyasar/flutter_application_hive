import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/features/helper/sinif_listesi_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  setUp(() {
    Hive.init('sinif');
  });
  test('Sinif listesi', () async {
    SinifListesiHelper sinifListesiHelper = SinifListesiHelper(ApplicationConstants.boxSinif);
    final values = sinifListesiHelper.getValues();
    expect(values?.length, 0);
  });
}
