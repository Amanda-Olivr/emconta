import 'package:mobx/mobx.dart';
import '../models/group.dart';

part 'group_store.g.dart';

class GroupStore = _GroupStoreBase with _$GroupStore;

abstract class _GroupStoreBase with Store {
  @observable
  ObservableList<Group> groups = ObservableList<Group>();

  @observable
  bool isLoading = false;

  @computed
  double get totalBalance =>
      groups.fold(0.0, (sum, g) => sum + g.totalBalance);

  @computed
  double get totalReceiving =>
      groups.fold(0.0, (sum, g) => sum + g.youReceive);

  @computed
  double get totalPaying =>
      groups.fold(0.0, (sum, g) => sum + g.youOwe);

  @action
  void loadGroups() {
    isLoading = true;
    Future.delayed(const Duration(milliseconds: 600), () {
      groups.clear();
      groups.addAll(Group.mockGroups);
      isLoading = false;
    });
  }

  @action
  void addGroup(Group group) {
    groups.add(group);
  }

  @action
  void updateGroup(Group updatedGroup) {
    final index = groups.indexWhere((g) => g.id == updatedGroup.id);
    if (index != -1) {
      groups[index] = updatedGroup;
    }
  }
}
