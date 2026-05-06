import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controllers/group_store.dart';
import '../../models/group.dart';
import '../../theme/app_theme.dart';
import '../widgets/design_components.dart';

class AddEditGroupScreen extends StatefulWidget {
  final Group? group; // Se nulo, estamos criando um novo

  const AddEditGroupScreen({super.key, this.group});

  @override
  State<AddEditGroupScreen> createState() => _AddEditGroupScreenState();
}

class _AddEditGroupScreenState extends State<AddEditGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _memberController = TextEditingController();
  final _budgetController = TextEditingController();

  String _category = 'Outros';
  List<String> _members = [];
  bool _isShared = false;
  String _budgetType = 'open'; // 'open' or 'estimate'

  final List<String> _categories = [
    'Viagem', 'Restaurante', 'Casa', 'Jogos', 'Presente', 'Esporte', 'Outros'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.group != null) {
      _nameController.text = widget.group!.name;
      _category = widget.group!.category;
      _members = List.from(widget.group!.members);
      _isShared = widget.group!.isShared;
      _budgetType = widget.group!.budgetType;
      if (widget.group!.budgetType == 'estimate') {
        _budgetController.text = widget.group!.estimatedBudget.toString();
      }
    } else {
      _members = ['Você']; // By default, the creator is a member
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _memberController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final store = Provider.of<GroupStore>(context, listen: false);
      
      double budget = 0.0;
      if (_budgetType == 'estimate' && _budgetController.text.isNotEmpty) {
        budget = double.tryParse(_budgetController.text.replaceAll(',', '.')) ?? 0.0;
      }

      if (widget.group == null) {
        // Create new
        final newGroup = Group(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: _nameController.text,
          category: _category,
          members: _members,
          status: GroupStatus.pending, // Default for new
          statusDetail: 'Novo grupo',
          isShared: _isShared,
          budgetType: _budgetType,
          estimatedBudget: budget,
        );
        store.addGroup(newGroup);
      } else {
        // Edit existing
        final updatedGroup = Group(
          id: widget.group!.id,
          name: _nameController.text,
          description: widget.group!.description,
          category: _category,
          totalBalance: widget.group!.totalBalance,
          youOwe: widget.group!.youOwe,
          youReceive: widget.group!.youReceive,
          members: _members,
          status: widget.group!.status,
          statusDetail: widget.group!.statusDetail,
          pendingProgress: widget.group!.pendingProgress,
          yourPart: widget.group!.yourPart,
          isShared: _isShared,
          budgetType: _budgetType,
          estimatedBudget: budget,
        );
        store.updateGroup(updatedGroup);
      }

      Navigator.pop(context);
    }
  }

  void _addMember() {
    if (_memberController.text.isNotEmpty) {
      setState(() {
        _members.add(_memberController.text.trim());
        _memberController.clear();
      });
    }
  }

  void _removeMember(String member) {
    if (member != 'Você') {
      setState(() {
        _members.remove(member);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.group != null;
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: const Color(0xFF020617),
        elevation: 0,
        title: Text(
          isEditing ? 'Editar Grupo' : 'Novo Grupo',
          style: GoogleFonts.epilogue(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppTheme.primaryContainer,
          ),
        ),
        iconTheme: const IconThemeData(color: AppTheme.onSurface),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nome do Grupo',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: AppTheme.onSurface),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppTheme.surfaceContainerHighest,
                  hintText: 'Ex: Viagem para Búzios',
                  hintStyle: TextStyle(color: AppTheme.outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Informe um nome' : null,
              ),
              const SizedBox(height: 24),
              
              Text(
                'Objetivo / Categoria',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _categories.map((cat) {
                  final isSelected = _category == cat;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) setState(() => _category = cat);
                    },
                    selectedColor: AppTheme.primaryContainer,
                    backgroundColor: AppTheme.surfaceContainerHighest,
                    labelStyle: TextStyle(
                      color: isSelected ? AppTheme.onPrimaryContainer : AppTheme.onSurface,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              Text(
                'Integrantes',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _memberController,
                      style: const TextStyle(color: AppTheme.onSurface),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppTheme.surfaceContainerHighest,
                        hintText: 'Nome do integrante',
                        hintStyle: TextStyle(color: AppTheme.outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onFieldSubmitted: (_) => _addMember(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: _addMember,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.add, color: AppTheme.onPrimaryContainer),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _members.map((m) {
                  return Chip(
                    label: Text(m, style: const TextStyle(color: AppTheme.onSurface)),
                    backgroundColor: AppTheme.surfaceContainerHighest,
                    deleteIcon: m == 'Você' ? null : const Icon(Icons.close, size: 16),
                    onDeleted: m == 'Você' ? null : () => _removeMember(m),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Compartilhar Grupo',
                            style: GoogleFonts.manrope(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Permitir que outros com o app acessem (em desenvolvimento)',
                            style: GoogleFonts.manrope(
                              fontSize: 12,
                              color: AppTheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _isShared,
                      onChanged: (val) => setState(() => _isShared = val),
                      activeColor: AppTheme.primaryContainer,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Verba do Grupo',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Em Aberto', style: TextStyle(color: AppTheme.onSurface, fontSize: 14)),
                      value: 'open',
                      groupValue: _budgetType,
                      onChanged: (val) => setState(() => _budgetType = val!),
                      contentPadding: EdgeInsets.zero,
                      activeColor: AppTheme.primaryContainer,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Estimativa', style: TextStyle(color: AppTheme.onSurface, fontSize: 14)),
                      value: 'estimate',
                      groupValue: _budgetType,
                      onChanged: (val) => setState(() => _budgetType = val!),
                      contentPadding: EdgeInsets.zero,
                      activeColor: AppTheme.primaryContainer,
                    ),
                  ),
                ],
              ),
              if (_budgetType == 'estimate') ...[
                const SizedBox(height: 8),
                TextFormField(
                  controller: _budgetController,
                  style: const TextStyle(color: AppTheme.onSurface),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppTheme.surfaceContainerHighest,
                    hintText: 'Valor estimado (R\$)',
                    hintStyle: TextStyle(color: AppTheme.outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.attach_money, color: AppTheme.outline),
                  ),
                ),
              ],
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryContainer,
                    foregroundColor: AppTheme.onPrimaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    isEditing ? 'SALVAR ALTERAÇÕES' : 'CRIAR GRUPO',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
