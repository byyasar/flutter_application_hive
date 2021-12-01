import 'package:mobx/mobx.dart';

part 'sinif_store.g.dart';

class SinifStore = _SinifId with _$SinifStore;

abstract class _SinifId with Store {
  @observable
  int sinifId = 0;

  @observable
  String sinifAd = "";

  @action
  void setSinifId(int sinifId) {
    sinifId = sinifId;
  }

  @action
  void setSinifAd(String sinifAd) {
    sinifAd = sinifAd;
  }
}
