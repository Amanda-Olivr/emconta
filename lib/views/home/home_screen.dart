import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../controllers/group_store.dart';
import '../../theme/app_theme.dart';
import '../widgets/design_components.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GroupStore store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    store = Provider.of<GroupStore>(context);
    if (store.groups.isEmpty) store.loadGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: SafeArea(
        child: Observer(
          builder: (_) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(),
                  const SizedBox(height: 24),
                  // Greeting
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Olá, Amanda! 👋',
                          style: GoogleFonts.epilogue(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.onSurface,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Aqui está o resumo das suas contas.',
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Quick Balance Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: MeshGradientCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelCaps('SEU SALDO GERAL', color: Colors.white.withOpacity(0.7)),
                          const SizedBox(height: 8),
                          NumberDisplay(
                            'R\$ 12.840,50',
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _buildQuickStat('A Receber', 'R\$ 4.200', AppTheme.secondaryContainer),
                              const SizedBox(width: 24),
                              _buildQuickStat('A Pagar', 'R\$ 1.150', AppTheme.tertiary),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  // Quick Actions
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Ações Rápidas',
                      style: GoogleFonts.epilogue(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(child: _buildActionCard(Icons.add_circle_outline, 'Novo\nGrupo', AppTheme.primaryContainer)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildActionCard(Icons.receipt_long, 'Nova\nDespesa', AppTheme.secondaryContainer)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildActionCard(Icons.send, 'Enviar\nLembrete', AppTheme.tertiary)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),
                  // Recent Groups
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Grupos Recentes',
                          style: GoogleFonts.epilogue(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.onSurface,
                          ),
                        ),
                        Text(
                          'Ver Todos',
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.secondaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (store.groups.isNotEmpty)
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: store.groups.length > 3 ? 3 : store.groups.length,
                        itemBuilder: (context, index) {
                          final group = store.groups[index];
                          return Container(
                            width: 200,
                            margin: const EdgeInsets.only(right: 12),
                            child: GlassCard(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: group.statusColor.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Icon(group.categoryIcon, color: group.statusColor, size: 18),
                                      ),
                                      const Spacer(),
                                      StatusChip(label: group.statusLabel, color: group.statusColor),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    group.name,
                                    style: GoogleFonts.epilogue(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.onSurface,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${group.members.length} participantes',
                                    style: GoogleFonts.manrope(
                                      fontSize: 13,
                                      color: AppTheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 40),
                ],
              ),
            );
          },
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
              letterSpacing: -0.5,
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

  Widget _buildQuickStat(String label, String amount, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(fontSize: 13, color: Colors.white.withOpacity(0.7)),
        ),
        const SizedBox(height: 4),
        NumberDisplay(amount, fontSize: 18, fontWeight: FontWeight.w700, color: color),
      ],
    );
  }

  Widget _buildActionCard(IconData icon, String label, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppTheme.onSurface,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
