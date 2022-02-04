import 'package:mobx/mobx.dart';
part 'temrinnot_store.g.dart';

class TemrinnotStore = _TemrinnotId with _$TemrinnotStore;

abstract class _TemrinnotId with Store {
  @observable
  int temrinnotId = -1;

  @observable
  int filtretemrinnotId = -1;

  @observable
  List<int> kriterler = [0, 0, 0, 0, 0];

  @observable
  String aciklama = '';

  @observable
  int puan = -1;

  @action
  void settemrinnotId(int temrinnotId) {
    this.temrinnotId = temrinnotId;
    //print('temrin id:$temrinId');
  }

  @action
  void setFiltretemrinId(int filtretemrinnotId) {
    this.filtretemrinnotId = filtretemrinnotId;
    //print('Filtre temrin id:$filtretemrinId');
  }

  @action
  void setKriterler(List<int> kriterler) {
    this.kriterler = kriterler;
    // print('kriterler $kriterler');
  }

  @action
  void setAciklama(String aciklama) {
    this.aciklama = aciklama;
    //print('aciklama $aciklama');
  }

  @computed
  int get toplam {
    int toplam = 0;
    for (var puan in kriterler) {
      toplam += puan;
    }
    puan = toplam;
    return toplam;
  }
}
