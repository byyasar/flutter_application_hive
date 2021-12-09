// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temrin_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TemrinStore on _TemrinId, Store {
  final _$temrinIdAtom = Atom(name: '_TemrinId.temrinId');

  @override
  int get temrinId {
    _$temrinIdAtom.reportRead();
    return super.temrinId;
  }

  @override
  set temrinId(int value) {
    _$temrinIdAtom.reportWrite(value, super.temrinId, () {
      super.temrinId = value;
    });
  }

  final _$filtretemrinIdAtom = Atom(name: '_TemrinId.filtretemrinId');

  @override
  int get filtretemrinId {
    _$filtretemrinIdAtom.reportRead();
    return super.filtretemrinId;
  }

  @override
  set filtretemrinId(int value) {
    _$filtretemrinIdAtom.reportWrite(value, super.filtretemrinId, () {
      super.filtretemrinId = value;
    });
  }

  final _$temrinKonusuAtom = Atom(name: '_TemrinId.temrinKonusu');

  @override
  String get temrinKonusu {
    _$temrinKonusuAtom.reportRead();
    return super.temrinKonusu;
  }

  @override
  set temrinKonusu(String value) {
    _$temrinKonusuAtom.reportWrite(value, super.temrinKonusu, () {
      super.temrinKonusu = value;
    });
  }

  final _$_TemrinIdActionController = ActionController(name: '_TemrinId');

  @override
  void settemrinId(int temrinId) {
    final _$actionInfo =
        _$_TemrinIdActionController.startAction(name: '_TemrinId.settemrinId');
    try {
      return super.settemrinId(temrinId);
    } finally {
      _$_TemrinIdActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFiltretemrinId(int filtretemrinId) {
    final _$actionInfo = _$_TemrinIdActionController.startAction(
        name: '_TemrinId.setFiltretemrinId');
    try {
      return super.setFiltretemrinId(filtretemrinId);
    } finally {
      _$_TemrinIdActionController.endAction(_$actionInfo);
    }
  }

  @override
  void settemrinKonusu(String temrinKonusu) {
    final _$actionInfo = _$_TemrinIdActionController.startAction(
        name: '_TemrinId.settemrinKonusu');
    try {
      return super.settemrinKonusu(temrinKonusu);
    } finally {
      _$_TemrinIdActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
temrinId: ${temrinId},
filtretemrinId: ${filtretemrinId},
temrinKonusu: ${temrinKonusu}
    ''';
  }
}
