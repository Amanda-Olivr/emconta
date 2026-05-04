import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/expense.dart';
import '../../theme/app_theme.dart';
import '../widgets/design_components.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recentActivity = Expense.mockRecentActivity;

    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // App Bar
            SliverToBoxAdapter(child: _buildAppBar()),
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelCaps('CONTAS DO MÊS', color: AppTheme.onSurfaceVariant),
                    const SizedBox(height: 4),
                    Text(
                      'Resumo de Dívidas',
                      style: GoogleFonts.epilogue(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // A Receber Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: _buildDebtCard(
                  title: 'A RECEBER',
                  amount: 'R\$ 2.450,00',
                  subtitle: '5 pendências ativas',
                  icon: Icons.arrow_downward,
                  gradient: const [Color(0xFF00F1FD), Color(0xFF00B4D8)],
                ),
              ),
            ),
            // A Pagar Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: _buildDebtCard(
                  title: 'A PAGAR',
                  amount: 'R\$ 1.120,45',
                  subtitle: 'Vencimento em 3 dias',
                  icon: Icons.arrow_upward,
                  gradient: const [Color(0xFFFF516A), Color(0xFFFF8A9E)],
                ),
              ),
            ),
            // Settle Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: _buildSettleSection(),
              ),
            ),
            // Recent Activity Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Atividades Recentes',
                      style: GoogleFonts.epilogue(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.onSurface,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Ver Tudo',
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.chevron_right, color: AppTheme.onSurfaceVariant, size: 18),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Activity Items
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _ActivityItem(expense: recentActivity[index]),
                    );
                  },
                  childCount: recentActivity.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.primaryContainer, width: 2),
              color: AppTheme.surfaceContainerHigh,
            ),
            child: const Icon(Icons.person, color: AppTheme.primaryContainer, size: 22),
          ),
          const SizedBox(width: 12),
          Text(
            'Em Conta',
            style: GoogleFonts.epilogue(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              color: AppTheme.primaryContainer,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }

  Widget _buildDebtCard({
    required String title,
    required String amount,
    required String subtitle,
    required IconData icon,
    required List<Color> gradient,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            top: -10,
            child: Icon(icon, size: 80, color: Colors.white.withOpacity(0.1)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 8),
              NumberDisplay(amount, fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.manrope(fontSize: 14, color: Colors.white.withOpacity(0.8)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettleSection() {
    return GlassCard(
      child: Column(
        children: [
          Text(
            'Acertar Contas',
            style: GoogleFonts.epilogue(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppTheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Liquide suas dívidas pendentes ou envie lembretes de pagamento com um toque.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 15,
              color: AppTheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          // Liquidar button
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: AppTheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.bolt, color: AppTheme.onPrimaryContainer, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'Liquidar Tudo',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Enviar Lembretes
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.outlineVariant, width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.share, color: AppTheme.onSurface, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Enviar Lembretes',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final Expense expense;

  const _ActivityItem({required this.expense});

  @override
  Widget build(BuildContext context) {
    final isPaidByYou = expense.paidBy == 'Você';
    final signPrefix = isPaidByYou ? '+ ' : '- ';
    final amountColor = isPaidByYou ? AppTheme.secondaryContainer : AppTheme.tertiary;
    final statusText = isPaidByYou ? 'PENDENTE' : 'A PAGAR';

    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: (isPaidByYou ? AppTheme.secondaryContainer : AppTheme.tertiary).withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(expense.icon, color: amountColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.title,
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Grupo: ${expense.groupName} • Pago por ${expense.paidBy}',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${signPrefix}R\$ ${expense.yourPart?.toStringAsFixed(2).replaceAll('.', ',') ?? '0,00'}',
                style: GoogleFonts.epilogue(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: amountColor,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: amountColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  statusText,
                  style: GoogleFonts.manrope(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: amountColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
