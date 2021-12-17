import 'package:mobx/mobx.dart';

part 'ders_store.g.dart';

class DersStore = _DersId with _$DersStore;

abstract class _DersId with Store {
  @observable
  int dersId = -1;

  @observable
  int filtredersId = -1;

  @observable
  String dersAd = "";

  @action
  void setDersId(int dersId) {
    this.dersId = dersId;
    //print('ders id:$dersId');
  }

  @action
  void setFiltreDersId(int filtredersId) {
    this.filtredersId = filtredersId;
    //print('Filtre ders id:$filtredersId');
  }

  @action
  void setDersAd(String dersAd) {
    this.dersAd = dersAd;
    //print('ders adı:$dersAd');
  }
}
