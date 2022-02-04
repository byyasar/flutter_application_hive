// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temrinnot_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TemrinnotStore on _TemrinnotId, Store {
  Computed<int>? _$toplamComputed;

  @override
  int get toplam => (_$toplamComputed ??=
          Computed<int>(() => super.toplam, name: '_TemrinnotId.toplam'))
      .value;

  final _$temrinnotIdAtom = Atom(name: '_TemrinnotId.temrinnotId');

  @override
  int get temrinnotId {
    _$temrinnotIdAtom.reportRead();
    return super.temrinnotId;
  }

  @override
  set temrinnotId(int value) {
    _$temrinnotIdAtom.reportWrite(value, super.temrinnotId, () {
      super.temrinnotId = value;
    });
  }

  final _$filtretemrinnotIdAtom = Atom(name: '_TemrinnotId.filtretemrinnotId');

  @override
  int get filtretemrinnotId {
    _$filtretemrinnotIdAtom.reportRead();
    return super.filtretemrinnotId;
  }

  @override
  set filtretemrinnotId(int value) {
    _$filtretemrinnotIdAtom.reportWrite(value, super.filtretemrinnotId, () {
      super.filtretemrinnotId = value;
    });
  }

  final _$kriterlerAtom = Atom(name: '_TemrinnotId.kriterler');

  @override
  List<int> get kriterler {
    _$kriterlerAtom.reportRead();
    return super.kriterler;
  }

  @override
  set kriterler(List<int> value) {
    _$kriterlerAtom.reportWrite(value, super.kriterler, () {
      super.kriterler = value;
    });
  }

  final _$aciklamaAtom = Atom(name: '_TemrinnotId.aciklama');

  @override
  String get aciklama {
    _$aciklamaAtom.reportRead();
    return super.aciklama;
  }

  @override
  set aciklama(String value) {
    _$aciklamaAtom.reportWrite(value, super.aciklama, () {
      super.aciklama = value;
    });
  }

  final _$puanAtom = Atom(name: '_TemrinnotId.puan');

  @override
  int get puan {
    _$puanAtom.reportRead();
    return super.puan;
  }

  @override
  set puan(int value) {
    _$puanAtom.reportWrite(value, super.puan, () {
      super.puan = value;
    });
  }

  final _$_TemrinnotIdActionController = ActionController(name: '_TemrinnotId');

  @override
  void settemrinnotId(int temrinnotId) {
    final _$actionInfo = _$_TemrinnotIdActionController.startAction(
        name: '_TemrinnotId.settemrinnotId');
    try {
      return super.settemrinnotId(temrinnotId);
    } finally {
      _$_TemrinnotIdActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFiltretemrinId(int filtretemrinnotId) {
    final _$actionInfo = _$_TemrinnotIdActionController.startAction(
        name: '_TemrinnotId.setFiltretemrinId');
    try {
      return super.setFiltretemrinId(filtretemrinnotId);
    } finally {
      _$_TemrinnotIdActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setKriterler(List<int> kriterler) {
    final _$actionInfo = _$_TemrinnotIdActionController.startAction(
        name: '_TemrinnotId.setKriterler');
    try {
      return super.setKriterler(kriterler);
    } finally {
      _$_TemrinnotIdActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAciklama(String aciklama) {
    final _$actionInfo = _$_TemrinnotIdActionController.startAction(
        name: '_TemrinnotId.setAciklama');
    try {
      return super.setAciklama(aciklama);
    } finally {
      _$_TemrinnotIdActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setToplam(int toplam) {
    final _$actionInfo = _$_TemrinnotIdActionController.startAction(
        name: '_TemrinnotId.setToplam');
    try {
      return super.setToplam(toplam);
    } finally {
      _$_TemrinnotIdActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
temrinnotId: ${temrinnotId},
filtretemrinnotId: ${filtretemrinnotId},
kriterler: ${kriterler},
aciklama: ${aciklama},
puan: ${puan},
toplam: ${toplam}
    ''';
  }
}
