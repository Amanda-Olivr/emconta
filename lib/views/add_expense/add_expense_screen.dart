import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/group.dart';
import '../../models/expense.dart';
import '../../theme/app_theme.dart';
import '../widgets/design_components.dart';

class AddExpenseScreen extends StatefulWidget {
  final Group group;

  const AddExpenseScreen({super.key, required this.group});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _amountController = TextEditingController(text: '0,00');
  final _descriptionController = TextEditingController();
  int _selectedPayerIndex = 0;
  ExpenseSplitType _selectedSplitType = ExpenseSplitType.equal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            _buildAppBar(context),
            // Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Amount Input
                    _buildAmountSection(),
                    // Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: _buildDescriptionInput(),
                    ),
                    // Paid By
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pago por',
                            style: GoogleFonts.epilogue(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.onSurface,
                            ),
                          ),
                          Text(
                            'Selecionar um',
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildPayerSelector(),
                    // Split Type
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
                      child: Text(
                        'Como dividir',
                        style: GoogleFonts.epilogue(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.onSurface,
                        ),
                      ),
                    ),
                    _buildSplitOptions(),
                    // Date and Group
                    const SizedBox(height: 16),
                    _buildInfoRow(Icons.calendar_today, 'Hoje, 14 de Outubro'),
                    _buildInfoRow(Icons.group, widget.group.name),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            // Save Button
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF020617),
        border: Border(bottom: BorderSide(color: const Color(0xFF1E293B))),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: AppTheme.onSurface, size: 24),
          ),
          const Spacer(),
          Text(
            'Adicionar Despesa',
            style: GoogleFonts.epilogue(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic,
              color: AppTheme.primaryContainer,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz, color: AppTheme.onSurface, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainer,
        border: Border(
          bottom: BorderSide(color: AppTheme.outlineVariant.withOpacity(0.3)),
        ),
      ),
      child: Column(
        children: [
          LabelCaps('VALOR DA DESPESA', color: AppTheme.primaryContainer),
          const SizedBox(height: 16),
          Text(
            '0,00',
            style: GoogleFonts.epilogue(
              fontSize: 56,
              fontWeight: FontWeight.w800,
              color: AppTheme.onSurface.withOpacity(0.3),
              letterSpacing: -2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.outlineVariant),
      ),
      child: TextField(
        controller: _descriptionController,
        style: GoogleFonts.manrope(color: AppTheme.onSurface),
        decoration: InputDecoration.collapsed(
          hintText: 'O que você comprou?',
          hintStyle: GoogleFonts.manrope(color: AppTheme.outline),
        ),
      ),
    );
  }

  Widget _buildPayerSelector() {
    final members = ['Você', 'Marina', 'Lucas'];
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: members.length + 1, // +1 for the dashed "add" circle
        itemBuilder: (context, index) {
          if (index < members.length) {
            final isSelected = index == _selectedPayerIndex;
            return GestureDetector(
              onTap: () => setState(() => _selectedPayerIndex = index),
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.surfaceContainerHighest,
                            border: Border.all(
                              color: isSelected ? AppTheme.primaryContainer : AppTheme.outlineVariant,
                              width: isSelected ? 3 : 1.5,
                            ),
                          ),
                          child: Icon(Icons.person, color: AppTheme.onSurfaceVariant, size: 28),
                        ),
                        if (isSelected)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.secondaryContainer,
                                border: Border.all(color: AppTheme.surface, width: 2),
                              ),
                              child: const Icon(Icons.check, size: 12, color: AppTheme.onSecondaryContainer),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      members[index],
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? AppTheme.onSurface : AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          // Dashed add circle
          return Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.outlineVariant,
                      width: 2,
                      // TODO: dashed effect not natively supported, using solid
                    ),
                  ),
                  child: const Icon(Icons.add, color: AppTheme.outline, size: 24),
                ),
                const SizedBox(height: 8),
                Text('N', style: GoogleFonts.manrope(fontSize: 14, color: AppTheme.onSurfaceVariant)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSplitOptions() {
    final options = [
      _SplitOption(ExpenseSplitType.equal, Icons.bar_chart, 'Igualmente', 'R\$ 0,00 cada'),
      _SplitOption(ExpenseSplitType.percentage, Icons.percent, 'Porcentagem', 'Ajustar partes'),
      _SplitOption(ExpenseSplitType.exact, Icons.crop_square, 'Valor exato', 'Definir quantia'),
      _SplitOption(ExpenseSplitType.weight, Icons.star, 'Peso', 'Cotas variáveis'),
    ];

    return Column(
      children: options.map((option) {
        final isSelected = _selectedSplitType == option.type;
        return GestureDetector(
          onTap: () => setState(() => _selectedSplitType = option.type),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.surfaceContainerHigh : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppTheme.primaryContainer : AppTheme.outlineVariant,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.primaryContainer.withOpacity(0.2)
                        : AppTheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    option.icon,
                    color: isSelected ? AppTheme.primaryContainer : AppTheme.onSurfaceVariant,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.title,
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        option.subtitle,
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          color: AppTheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppTheme.primaryContainer : AppTheme.outlineVariant,
                      width: 2,
                    ),
                    color: isSelected ? AppTheme.primaryContainer : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, size: 16, color: AppTheme.onPrimaryContainer)
                      : null,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerHigh.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.outline, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.manrope(
                fontSize: 16,
                color: AppTheme.onSurface,
              ),
            ),
          ),
          const Icon(Icons.chevron_right, color: AppTheme.outline, size: 22),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: AppTheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFA078FF).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Salvar Despesa',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, color: AppTheme.onPrimaryContainer, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}

class _SplitOption {
  final ExpenseSplitType type;
  final IconData icon;
  final String title;
  final String subtitle;

  _SplitOption(this.type, this.icon, this.title, this.subtitle);
}
