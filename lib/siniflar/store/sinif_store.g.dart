// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sinif_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SinifStore on _SinifId, Store {
  final _$sinifIdAtom = Atom(name: '_SinifId.sinifId');

  @override
  int get sinifId {
    _$sinifIdAtom.reportRead();
    return super.sinifId;
  }

  @override
  set sinifId(int value) {
    _$sinifIdAtom.reportWrite(value, super.sinifId, () {
      super.sinifId = value;
    });
  }

  final _$filtreSinifIdAtom = Atom(name: '_SinifId.filtreSinifId');

  @override
  int get filtreSinifId {
    _$filtreSinifIdAtom.reportRead();
    return super.filtreSinifId;
  }

  @override
  set filtreSinifId(int value) {
    _$filtreSinifIdAtom.reportWrite(value, super.filtreSinifId, () {
      super.filtreSinifId = value;
    });
  }

  final _$sinifAdAtom = Atom(name: '_SinifId.sinifAd');

  @override
  String get sinifAd {
    _$sinifAdAtom.reportRead();
    return super.sinifAd;
  }

  @override
  set sinifAd(String value) {
    _$sinifAdAtom.reportWrite(value, super.sinifAd, () {
      super.sinifAd = value;
    });
  }

  final _$_SinifIdActionController = ActionController(name: '_SinifId');

  @override
  void setSinifId(int sinifId) {
    final _$actionInfo =
        _$_SinifIdActionController.startAction(name: '_SinifId.setSinifId');
    try {
      return super.setSinifId(sinifId);
    } finally {
      _$_SinifIdActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFiltreSinifId(int filtreSinifId) {
    final _$actionInfo = _$_SinifIdActionController.startAction(
        name: '_SinifId.setFiltreSinifId');
    try {
      return super.setFiltreSinifId(filtreSinifId);
    } finally {
      _$_SinifIdActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSinifAd(String sinifAd) {
    final _$actionInfo =
        _$_SinifIdActionController.startAction(name: '_SinifId.setSinifAd');
    try {
      return super.setSinifAd(sinifAd);
    } finally {
      _$_SinifIdActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sinifId: ${sinifId},
filtreSinifId: ${filtreSinifId},
sinifAd: ${sinifAd}
    ''';
  }
}
