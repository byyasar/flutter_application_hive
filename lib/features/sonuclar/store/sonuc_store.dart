import 'package:mobx/mobx.dart';

part 'sonuc_store.g.dart';

class SonucStore = _SonucId with _$SonucStore;

abstract class _SonucId with Store {
  @observable
  int sayac = 0;

  @observable
  int toplam = 0;

  @computed
  double get ortalama {
    //print('ortalama=${(toplam / sayac)}');
    return (toplam / sayac);
  }

  @action
  void sayacArttir() {
    sayac += 1;
    //print('sayac: $sayac');
  }

  @action
  void setSayacSifirla() {
    sayac = 0;
  }

  @action
  void toplamaEkle(int puan) {
    toplam += puan;
    //print(toplam);
  }
}
