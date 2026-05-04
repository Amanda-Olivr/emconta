import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../widgets/design_components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // App Bar
              _buildAppBar(),
              const SizedBox(height: 24),
              // Avatar
              _buildProfileHeader(),
              const SizedBox(height: 32),
              // Stats
              _buildStatsRow(),
              const SizedBox(height: 32),
              // Menu Items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _buildMenuItem(Icons.person_outline, 'Editar Perfil'),
                    _buildMenuItem(Icons.notifications_outlined, 'Notificações'),
                    _buildMenuItem(Icons.payment, 'Formas de Pagamento'),
                    _buildMenuItem(Icons.shield_outlined, 'Privacidade'),
                    _buildMenuItem(Icons.color_lens_outlined, 'Aparência'),
                    _buildMenuItem(Icons.help_outline, 'Ajuda & Suporte'),
                    const SizedBox(height: 16),
                    _buildMenuItem(Icons.logout, 'Sair', isDestructive: true),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
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
      ),
      child: Row(
        children: [
          Text(
            'Perfil',
            style: GoogleFonts.epilogue(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppTheme.primaryContainer,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined, color: Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppTheme.primaryContainer, width: 3),
            color: AppTheme.surfaceContainerHigh,
          ),
          child: const Icon(Icons.person, color: AppTheme.primaryContainer, size: 48),
        ),
        const SizedBox(height: 16),
        Text(
          'Amanda Silva',
          style: GoogleFonts.epilogue(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'amanda.silva@email.com',
          style: GoogleFonts.manrope(
            fontSize: 15,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(child: _buildStatCard('5', 'Grupos\nAtivos')),
          const SizedBox(width: 12),
          Expanded(child: _buildStatCard('23', 'Despesas\neste mês')),
          const SizedBox(width: 12),
          Expanded(child: _buildStatCard('98%', 'Taxa de\nPagamento')),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          NumberDisplay(value, fontSize: 28, fontWeight: FontWeight.w800, color: AppTheme.primaryContainer),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppTheme.onSurfaceVariant,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {bool isDestructive = false}) {
    final color = isDestructive ? AppTheme.tertiaryContainer : AppTheme.onSurface;
    final iconBgColor = isDestructive
        ? AppTheme.tertiaryContainer.withOpacity(0.1)
        : AppTheme.surfaceContainerHighest;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerHigh.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: AppTheme.outline, size: 22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onTap: () {},
      ),
    );
  }
}
