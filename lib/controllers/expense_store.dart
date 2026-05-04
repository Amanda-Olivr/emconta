import 'package:mobx/mobx.dart';
import '../models/expense.dart';

part 'expense_store.g.dart';

class ExpenseStore = _ExpenseStoreBase with _$ExpenseStore;

abstract class _ExpenseStoreBase with Store {
  @observable
  ObservableList<Expense> expenses = ObservableList<Expense>();

  @observable
  ObservableList<Expense> recentActivity = ObservableList<Expense>();

  @observable
  bool isLoading = false;

  @action
  void loadExpenses(String groupId) {
    isLoading = true;
    Future.delayed(const Duration(milliseconds: 400), () {
      expenses.clear();
      expenses.addAll(Expense.getMockExpenses(groupId));
      isLoading = false;
    });
  }

  @action
  void loadRecentActivity() {
    recentActivity.clear();
    recentActivity.addAll(Expense.mockRecentActivity);
  }

  @action
  void addExpense(Expense expense) {
    expenses.add(expense);
  }
}
