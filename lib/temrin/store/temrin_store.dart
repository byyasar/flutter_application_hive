import 'package:mobx/mobx.dart';

part 'temrin_store.g.dart';

class TemrinStore = _TemrinId with _$TemrinStore;

abstract class _TemrinId with Store {
  @observable
  int temrinId = -1;

  @observable
  int filtretemrinId = -1;

  @observable
  String temrinKonusu = "";

  @action
  void settemrinId(int temrinId) {
    this.temrinId = temrinId;
    //print('temrin id:$temrinId');
  }

  @action
  void setFiltretemrinId(int filtretemrinId) {
    this.filtretemrinId = filtretemrinId;
    //print('Filtre temrin id:$filtretemrinId');
  }

  @action
  void settemrinKonusu(String temrinKonusu) {
    this.temrinKonusu = temrinKonusu;
    //print('temrin adı:$temrinKonusu');
  }
}
