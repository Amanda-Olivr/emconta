// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ExpenseStore on _ExpenseStoreBase, Store {
  late final _$expensesAtom = Atom(
    name: '_ExpenseStoreBase.expenses',
    context: context,
  );

  @override
  ObservableList<Expense> get expenses {
    _$expensesAtom.reportRead();
    return super.expenses;
  }

  @override
  set expenses(ObservableList<Expense> value) {
    _$expensesAtom.reportWrite(value, super.expenses, () {
      super.expenses = value;
    });
  }

  late final _$recentActivityAtom = Atom(
    name: '_ExpenseStoreBase.recentActivity',
    context: context,
  );

  @override
  ObservableList<Expense> get recentActivity {
    _$recentActivityAtom.reportRead();
    return super.recentActivity;
  }

  @override
  set recentActivity(ObservableList<Expense> value) {
    _$recentActivityAtom.reportWrite(value, super.recentActivity, () {
      super.recentActivity = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_ExpenseStoreBase.isLoading',
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

  late final _$_ExpenseStoreBaseActionController = ActionController(
    name: '_ExpenseStoreBase',
    context: context,
  );

  @override
  void loadExpenses(String groupId) {
    final _$actionInfo = _$_ExpenseStoreBaseActionController.startAction(
      name: '_ExpenseStoreBase.loadExpenses',
    );
    try {
      return super.loadExpenses(groupId);
    } finally {
      _$_ExpenseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadRecentActivity() {
    final _$actionInfo = _$_ExpenseStoreBaseActionController.startAction(
      name: '_ExpenseStoreBase.loadRecentActivity',
    );
    try {
      return super.loadRecentActivity();
    } finally {
      _$_ExpenseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addExpense(Expense expense) {
    final _$actionInfo = _$_ExpenseStoreBaseActionController.startAction(
      name: '_ExpenseStoreBase.addExpense',
    );
    try {
      return super.addExpense(expense);
    } finally {
      _$_ExpenseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
expenses: ${expenses},
recentActivity: ${recentActivity},
isLoading: ${isLoading}
    ''';
  }
}
