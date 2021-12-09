// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ogrenci_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OgrenciStore on _OgrenciId, Store {
  final _$ogrenciIdAtom = Atom(name: '_OgrenciId.ogrenciId');

  @override
  int get ogrenciId {
    _$ogrenciIdAtom.reportRead();
    return super.ogrenciId;
  }

  @override
  set ogrenciId(int value) {
    _$ogrenciIdAtom.reportWrite(value, super.ogrenciId, () {
      super.ogrenciId = value;
    });
  }

  final _$filtreOgrenciIdAtom = Atom(name: '_OgrenciId.filtreOgrenciId');

  @override
  int get filtreOgrenciId {
    _$filtreOgrenciIdAtom.reportRead();
    return super.filtreOgrenciId;
  }

  @override
  set filtreOgrenciId(int value) {
    _$filtreOgrenciIdAtom.reportWrite(value, super.filtreOgrenciId, () {
      super.filtreOgrenciId = value;
    });
  }

  final _$_OgrenciIdActionController = ActionController(name: '_OgrenciId');

  @override
  void setOgrenciId(int ogrenciId) {
    final _$actionInfo = _$_OgrenciIdActionController.startAction(
        name: '_OgrenciId.setOgrenciId');
    try {
      return super.setOgrenciId(ogrenciId);
    } finally {
      _$_OgrenciIdActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFiltreOgrenciId(int filtreOgrenciId) {
    final _$actionInfo = _$_OgrenciIdActionController.startAction(
        name: '_OgrenciId.setFiltreOgrenciId');
    try {
      return super.setFiltreOgrenciId(filtreOgrenciId);
    } finally {
      _$_OgrenciIdActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
ogrenciId: ${ogrenciId},
filtreOgrenciId: ${filtreOgrenciId}
    ''';
  }
}
