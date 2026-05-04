// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GroupStore on _GroupStoreBase, Store {
  Computed<double>? _$totalBalanceComputed;

  @override
  double get totalBalance => (_$totalBalanceComputed ??= Computed<double>(
    () => super.totalBalance,
    name: '_GroupStoreBase.totalBalance',
  )).value;
  Computed<double>? _$totalReceivingComputed;

  @override
  double get totalReceiving => (_$totalReceivingComputed ??= Computed<double>(
    () => super.totalReceiving,
    name: '_GroupStoreBase.totalReceiving',
  )).value;
  Computed<double>? _$totalPayingComputed;

  @override
  double get totalPaying => (_$totalPayingComputed ??= Computed<double>(
    () => super.totalPaying,
    name: '_GroupStoreBase.totalPaying',
  )).value;

  late final _$groupsAtom = Atom(
    name: '_GroupStoreBase.groups',
    context: context,
  );

  @override
  ObservableList<Group> get groups {
    _$groupsAtom.reportRead();
    return super.groups;
  }

  @override
  set groups(ObservableList<Group> value) {
    _$groupsAtom.reportWrite(value, super.groups, () {
      super.groups = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_GroupStoreBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$_GroupStoreBaseActionController = ActionController(
    name: '_GroupStoreBase',
    context: context,
  );

  @override
  void loadGroups() {
    final _$actionInfo = _$_GroupStoreBaseActionController.startAction(
      name: '_GroupStoreBase.loadGroups',
    );
    try {
      return super.loadGroups();
    } finally {
      _$_GroupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addGroup(Group group) {
    final _$actionInfo = _$_GroupStoreBaseActionController.startAction(
      name: '_GroupStoreBase.addGroup',
    );
    try {
      return super.addGroup(group);
    } finally {
      _$_GroupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
groups: ${groups},
isLoading: ${isLoading},
totalBalance: ${totalBalance},
totalReceiving: ${totalReceiving},
totalPaying: ${totalPaying}
    ''';
  }
}
