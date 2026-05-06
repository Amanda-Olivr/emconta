import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controllers/group_store.dart';
import '../../models/group.dart';
import '../../theme/app_theme.dart';
import '../widgets/design_components.dart';
import '../group_detail/group_detail_screen.dart';
import 'add_edit_group_screen.dart';

class GroupsListScreen extends StatefulWidget {
  const GroupsListScreen({super.key});

  @override
  State<GroupsListScreen> createState() => _GroupsListScreenState();
}

class _GroupsListScreenState extends State<GroupsListScreen> {
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
      body: Observer(
        builder: (_) {
          if (store.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppTheme.primaryContainer),
            );
          }

          return Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // AppBar
                  SliverToBoxAdapter(child: _buildAppBar()),
                  // Hero Balance Card
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: _buildHeroBalanceCard(),
                    ),
                  ),
                  // Search Bar
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                      child: _buildSearchBar(),
                    ),
                  ),
                  // Group Cards
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final group = store.groups[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _GroupCard(group: group),
                          );
                        },
                        childCount: store.groups.length,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
              // FAB
              Positioned(
                bottom: 24,
                right: 24,
                child: _buildFAB(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return SafeArea(
      bottom: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF020617),
          border: Border(
            bottom: BorderSide(color: const Color(0xFF1E293B)),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8B5CF6).withOpacity(0.1),
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          children: [
            // Profile avatar
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
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined, color: Color(0xFF94A3B8)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBalanceCard() {
    return MeshGradientCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelCaps('SALDO TOTAL EM GRUPOS', color: AppTheme.onPrimaryContainer.withOpacity(0.8)),
          const SizedBox(height: 8),
          NumberDisplay(
            'R\$ 12.840,50',
            fontSize: 40,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildPillBadge(
                icon: Icons.trending_up,
                iconColor: AppTheme.secondaryContainer,
                text: 'Recebendo: R\$ 4.200',
              ),
              const SizedBox(width: 12),
              _buildPillBadge(
                icon: Icons.trending_down,
                iconColor: AppTheme.tertiary,
                text: 'Pagando: R\$ 1.150',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPillBadge({
    required IconData icon,
    required Color iconColor,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.manrope(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.outlineVariant),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: AppTheme.outline, size: 22),
                const SizedBox(width: 12),
                Text(
                  'Buscar grupos...',
                  style: GoogleFonts.manrope(
                    color: AppTheme.outline,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.outlineVariant),
          ),
          child: const Icon(Icons.tune, color: AppTheme.onSurface, size: 22),
        ),
      ],
    );
  }

  Widget _buildFAB() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddEditGroupScreen()),
        );
      },
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: AppTheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA078FF).withOpacity(0.4),
              blurRadius: 30,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(Icons.add, color: AppTheme.onPrimaryContainer, size: 32),
      ),
    );
  }
}

// ==================== GROUP CARD ====================

class _GroupCard extends StatelessWidget {
  final Group group;

  const _GroupCard({required this.group});

  @override
  Widget build(BuildContext context) {
    if (group.status == GroupStatus.pending) {
      return _buildPendingCard(context);
    }
    return _buildStandardCard(context);
  }

  Widget _buildStandardCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => GroupDetailScreen(group: group)),
        );
      },
      child: GlassCard(
        borderLeftColor: group.statusColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row: icon + status badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: group.statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(group.categoryIcon, color: group.statusColor, size: 24),
                ),
                StatusChip(label: group.statusLabel, color: group.statusColor),
              ],
            ),
            const SizedBox(height: 20),
            // Title
            Text(
              group.name,
              style: GoogleFonts.epilogue(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${group.members.length} participantes • ${group.statusDetail ?? ''}',
              style: GoogleFonts.manrope(
                fontSize: 15,
                color: AppTheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            // Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelCaps('SUA PARTE'),
                    const SizedBox(height: 4),
                    NumberDisplay(
                      'R\$ ${group.yourPart.toStringAsFixed(2).replaceAll('.', ',')}',
                      color: group.statusColor,
                    ),
                  ],
                ),
                if (group.status == GroupStatus.paying)
                  _buildPayButton()
                else if (group.status == GroupStatus.receiving && group.members.length > 3)
                  _buildAvatarStack()
                else if (group.status == GroupStatus.receiving)
                  Icon(Icons.autorenew, color: AppTheme.outline, size: 24)
                else if (group.status == GroupStatus.finished)
                  const Icon(Icons.verified, color: AppTheme.primaryContainer, size: 28),
              ],
            ),
            if (group.status == GroupStatus.finished) ...[
              const SizedBox(height: 8),
              const LabelCaps('TUDO EM CONTA'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPendingCard(BuildContext context) {
    return GlassCard(
      isDashed: true,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.pending, color: AppTheme.primaryContainer, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.name,
                      style: GoogleFonts.epilogue(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      group.statusDetail ?? '',
                      style: GoogleFonts.manrope(
                        fontSize: 15,
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: group.pendingProgress ?? 0,
                    backgroundColor: AppTheme.surfaceContainerHighest,
                    color: AppTheme.primaryContainer,
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              LabelCaps(
                '${((group.pendingProgress ?? 0) * 100).toInt()}%',
                color: AppTheme.primaryContainer,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.tertiary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF516A).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        'PAGAR',
        style: GoogleFonts.manrope(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
          color: AppTheme.onTertiaryContainer,
        ),
      ),
    );
  }

  Widget _buildAvatarStack() {
    return SizedBox(
      width: 80,
      height: 32,
      child: Stack(
        children: [
          ...List.generate(2, (i) {
            return Positioned(
              left: i * 20.0,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.surface, width: 2),
                  color: AppTheme.surfaceContainerHighest,
                ),
                child: Icon(Icons.person, size: 16, color: AppTheme.onSurfaceVariant),
              ),
            );
          }),
          Positioned(
            left: 40,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.surface, width: 2),
                color: AppTheme.surfaceContainerHighest,
              ),
              child: Center(
                child: Text(
                  '+${group.members.length - 3}',
                  style: GoogleFonts.manrope(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.onSurface,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
