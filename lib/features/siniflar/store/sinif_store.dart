import 'package:mobx/mobx.dart';

part 'sinif_store.g.dart';

class SinifStore = _SinifId with _$SinifStore;

abstract class _SinifId with Store {
  @observable
  int sinifId = -1;

  @observable
  int filtreSinifId = -1;

  @observable
  String sinifAd = "";

  @action
  void setSinifId(int sinifId) {
    this.sinifId = sinifId;
    //print('sinif id:$sinifId');
  }

  @action
  void setFiltreSinifId(int filtreSinifId) {
    this.filtreSinifId = filtreSinifId;
    //print('filtre sinif id:$filtreSinifId');
  }

  @action
  void setSinifAd(String sinifAd) {
    this.sinifAd = sinifAd;
    //print('sinif adı:$sinifAd');
  }
}
