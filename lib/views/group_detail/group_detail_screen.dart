import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controllers/expense_store.dart';
import '../../controllers/group_store.dart';
import '../../models/group.dart';
import '../../models/expense.dart';
import '../../theme/app_theme.dart';
import '../widgets/design_components.dart';
import '../add_expense/add_expense_screen.dart';
import '../home/add_edit_group_screen.dart';

class GroupDetailScreen extends StatefulWidget {
  final Group group;

  const GroupDetailScreen({super.key, required this.group});

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  late ExpenseStore store;
  late GroupStore groupStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    store = Provider.of<ExpenseStore>(context);
    groupStore = Provider.of<GroupStore>(context);
    store.loadExpenses(widget.group.id);
  }

  Group get _currentGroup {
    return groupStore.groups.firstWhere(
      (g) => g.id == widget.group.id,
      orElse: () => widget.group,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: SafeArea(
        child: Observer(
          builder: (_) {
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // App Bar
                SliverToBoxAdapter(child: _buildAppBar(context)),
                // Group Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                    child: _buildGroupHeader(_currentGroup),
                  ),
                ),
                // Balance Card
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: _buildBalanceCard(_currentGroup),
                  ),
                ),
                // Add Expense Button
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: _buildAddExpenseButton(context, _currentGroup),
                  ),
                ),
                // Activities Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Atividades Recentes',
                          style: GoogleFonts.epilogue(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.onSurface,
                          ),
                        ),
                        Text(
                          'Ver Tudo',
                          style: GoogleFonts.manrope(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.secondaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Expense List
                if (store.isLoading)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(color: AppTheme.primaryContainer),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final expense = store.expenses[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _ExpenseCard(expense: expense),
                          );
                        },
                        childCount: store.expenses.length,
                      ),
                    ),
                  ),
                // Members Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: _buildMembersSection(_currentGroup),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF020617),
        border: Border(bottom: BorderSide(color: const Color(0xFF1E293B))),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5CF6).withOpacity(0.1),
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: AppTheme.onSurface),
          ),
          Text(
            'Em Conta',
            style: GoogleFonts.epilogue(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              color: AppTheme.primaryContainer,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditGroupScreen(group: widget.group),
                ),
              );
            },
            icon: const Icon(Icons.edit_outlined, color: Color(0xFF94A3B8)),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.primaryContainer, width: 2),
              color: AppTheme.surfaceContainerHigh,
            ),
            child: const Icon(Icons.person, color: AppTheme.primaryContainer, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupHeader(Group group) {
    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: group.statusColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(group.categoryIcon, color: AppTheme.secondaryContainer, size: 32),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                group.name,
                style: GoogleFonts.epilogue(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${group.members.length} integrantes ativos',
                style: GoogleFonts.manrope(
                  fontSize: 15,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceCard(Group group) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFA078FF),
            Color(0xFFD0BCFF),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA078FF).withOpacity(0.3),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelCaps('SALDO TOTAL DO GRUPO', color: AppTheme.onPrimaryContainer.withOpacity(0.8)),
          const SizedBox(height: 8),
          NumberDisplay(
            'R\$ ${group.totalBalance.toStringAsFixed(2).replaceAll('.', ',')}',
            fontSize: 42,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          const SizedBox(height: 24),
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.2),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelCaps('VOCÊ DEVE', color: Colors.white.withOpacity(0.7)),
                  const SizedBox(height: 4),
                  NumberDisplay(
                    'R\$ ${group.youOwe.toStringAsFixed(2).replaceAll('.', ',')}',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  LabelCaps('A RECEBER', color: Colors.white.withOpacity(0.7)),
                  const SizedBox(height: 4),
                  NumberDisplay(
                    'R\$ ${group.youReceive.toStringAsFixed(2).replaceAll('.', ',')}',
                    fontSize: 20,
                    color: const Color(0xFF00F1FD),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddExpenseButton(BuildContext context, Group group) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddExpenseScreen(group: group),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.outlineVariant),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_circle_outline, color: AppTheme.onSurface, size: 22),
            const SizedBox(width: 12),
            Text(
              'Add Expense',
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembersSection(Group group) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Membros do Grupo',
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          // Avatar stack
          Row(
            children: [
              ...List.generate(
                group.members.length > 3 ? 3 : group.members.length,
                (i) => Container(
                  margin: EdgeInsets.only(left: i == 0 ? 0 : 0),
                  child: Align(
                    widthFactor: 0.7,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppTheme.surface, width: 2),
                        color: AppTheme.surfaceContainerHighest,
                      ),
                      child: Icon(Icons.person, size: 20, color: AppTheme.onSurfaceVariant),
                    ),
                  ),
                ),
              ),
              if (group.members.length > 3)
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.surface, width: 2),
                    color: AppTheme.primaryContainer.withOpacity(0.3),
                  ),
                  child: Center(
                    child: Text(
                      '+${group.members.length - 3}',
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryContainer,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Marina é a maior pagadora do grupo até agora.',
            style: GoogleFonts.manrope(
              fontSize: 15,
              color: AppTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== EXPENSE CARD ====================

class _ExpenseCard extends StatelessWidget {
  final Expense expense;

  const _ExpenseCard({required this.expense});

  @override
  Widget build(BuildContext context) {
    final isPaidByYou = expense.paidBy == 'Você';

    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(expense.icon, color: AppTheme.primaryContainer, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.title,
                  style: GoogleFonts.epilogue(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'PAGO POR ${expense.paidBy.toUpperCase()} • ${expense.formattedDate.toUpperCase()}',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              NumberDisplay(
                'R\$ ${expense.amount.toStringAsFixed(2).replaceAll('.', ',')}',
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              if (expense.yourPart != null && !isPaidByYou) ...[
                const SizedBox(height: 4),
                Text(
                  'SUA PARTE R\$ ${expense.yourPart!.toStringAsFixed(0)}',
                  style: GoogleFonts.manrope(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: AppTheme.secondaryContainer,
                  ),
                ),
              ] else if (isPaidByYou) ...[
                const SizedBox(height: 4),
                Text(
                  'DIVIDIDO IGUAL',
                  style: GoogleFonts.manrope(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: AppTheme.secondaryContainer,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
