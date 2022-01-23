// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sonuc_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SonucStore on _SonucId, Store {
  Computed<double>? _$ortalamaComputed;

  @override
  double get ortalama => (_$ortalamaComputed ??=
          Computed<double>(() => super.ortalama, name: '_SonucId.ortalama'))
      .value;

  final _$sayacAtom = Atom(name: '_SonucId.sayac');

  @override
  int get sayac {
    _$sayacAtom.reportRead();
    return super.sayac;
  }

  @override
  set sayac(int value) {
    _$sayacAtom.reportWrite(value, super.sayac, () {
      super.sayac = value;
    });
  }

  final _$toplamAtom = Atom(name: '_SonucId.toplam');

  @override
  int get toplam {
    _$toplamAtom.reportRead();
    return super.toplam;
  }

  @override
  set toplam(int value) {
    _$toplamAtom.reportWrite(value, super.toplam, () {
      super.toplam = value;
    });
  }

  final _$_SonucIdActionController = ActionController(name: '_SonucId');

  @override
  void sayacArttir() {
    final _$actionInfo =
        _$_SonucIdActionController.startAction(name: '_SonucId.sayacArttir');
    try {
      return super.sayacArttir();
    } finally {
      _$_SonucIdActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSayacSifirla() {
    final _$actionInfo = _$_SonucIdActionController.startAction(
        name: '_SonucId.setSayacSifirla');
    try {
      return super.setSayacSifirla();
    } finally {
      _$_SonucIdActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toplamaEkle(int puan) {
    final _$actionInfo =
        _$_SonucIdActionController.startAction(name: '_SonucId.toplamaEkle');
    try {
      return super.toplamaEkle(puan);
    } finally {
      _$_SonucIdActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sayac: ${sayac},
toplam: ${toplam},
ortalama: ${ortalama}
    ''';
  }
}
