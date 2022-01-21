import 'package:mobx/mobx.dart';

part 'ogrenci_store.g.dart';

class OgrenciStore = _OgrenciId with _$OgrenciStore;

abstract class _OgrenciId with Store {
  @observable
  int ogrenciId = -1;
  @observable
  int filtreOgrenciId = -1;
  @observable
  String ogrenciAd = "";

  @action
  void setOgrenciId(int ogrenciId) {
    this.ogrenciId = ogrenciId;
    //print('Ogrenci id:$OgrenciId');
  }

  @action
  void setOgrenciAd(String ogrenciAd) {
    this.ogrenciAd = ogrenciAd;
    //print('Ogrenci id:$OgrenciId');
  }

  @action
  void setFiltreOgrenciId(int filtreOgrenciId) {
    this.filtreOgrenciId = filtreOgrenciId;
    //print('Filtre Ogrenci id:$filtreOgrenciId');
  }
}
