// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ders_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DersStore on _DersId, Store {
  final _$dersIdAtom = Atom(name: '_DersId.dersId');

  @override
  int get dersId {
    _$dersIdAtom.reportRead();
    return super.dersId;
  }

  @override
  set dersId(int value) {
    _$dersIdAtom.reportWrite(value, super.dersId, () {
      super.dersId = value;
    });
  }

  final _$filtredersIdAtom = Atom(name: '_DersId.filtredersId');

  @override
  int get filtredersId {
    _$filtredersIdAtom.reportRead();
    return super.filtredersId;
  }

  @override
  set filtredersId(int value) {
    _$filtredersIdAtom.reportWrite(value, super.filtredersId, () {
      super.filtredersId = value;
    });
  }

  final _$dersAdAtom = Atom(name: '_DersId.dersAd');

  @override
  String get dersAd {
    _$dersAdAtom.reportRead();
    return super.dersAd;
  }

  @override
  set dersAd(String value) {
    _$dersAdAtom.reportWrite(value, super.dersAd, () {
      super.dersAd = value;
    });
  }

  final _$_DersIdActionController = ActionController(name: '_DersId');

  @override
  void setDersId(int dersId) {
    final _$actionInfo =
        _$_DersIdActionController.startAction(name: '_DersId.setDersId');
    try {
      return super.setDersId(dersId);
    } finally {
      _$_DersIdActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFiltreDersId(int filtredersId) {
    final _$actionInfo =
        _$_DersIdActionController.startAction(name: '_DersId.setFiltreDersId');
    try {
      return super.setFiltreDersId(filtredersId);
    } finally {
      _$_DersIdActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDersAd(String dersAd) {
    final _$actionInfo =
        _$_DersIdActionController.startAction(name: '_DersId.setDersAd');
    try {
      return super.setDersAd(dersAd);
    } finally {
      _$_DersIdActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dersId: ${dersId},
filtredersId: ${filtredersId},
dersAd: ${dersAd}
    ''';
  }
}
