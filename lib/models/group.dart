import 'package:flutter/material.dart';

enum GroupStatus { receiving, paying, pending, finished }

class Group {
  final String id;
  final String name;
  final String? description;
  final String category;
  final double totalBalance;
  final double youOwe;
  final double youReceive;
  final List<String> members;
  final GroupStatus status;
  final String? statusDetail; // Ex: "Vence em 12 dias", "Vence hoje"
  final double? pendingProgress; // 0.0 - 1.0 for pending groups
  final double yourPart;
  final bool isShared;
  final String budgetType; // 'estimate', 'open'
  final double estimatedBudget;

  Group({
    required this.id,
    required this.name,
    this.description,
    required this.category,
    this.totalBalance = 0.0,
    this.youOwe = 0.0,
    this.youReceive = 0.0,
    required this.members,
    required this.status,
    this.statusDetail,
    this.pendingProgress,
    this.yourPart = 0.0,
    this.isShared = false,
    this.budgetType = 'open',
    this.estimatedBudget = 0.0,
  });

  IconData get categoryIcon {
    switch (category.toLowerCase()) {
      case 'viagem':
        return Icons.beach_access;
      case 'restaurante':
        return Icons.restaurant;
      case 'casa':
        return Icons.home_rounded;
      case 'jogos':
        return Icons.sports_esports;
      case 'presente':
        return Icons.card_giftcard;
      case 'esporte':
        return Icons.sports_soccer;
      default:
        return Icons.receipt_long_rounded;
    }
  }

  Color get statusColor {
    switch (status) {
      case GroupStatus.receiving:
        return const Color(0xFF00F1FD); // Cyber Teal
      case GroupStatus.paying:
        return const Color(0xFFFFB2B7); // Pulse Pink
      case GroupStatus.pending:
        return const Color(0xFFA078FF); // Primary Container
      case GroupStatus.finished:
        return const Color(0xFF958EA0); // Outline
    }
  }

  String get statusLabel {
    switch (status) {
      case GroupStatus.receiving:
        return 'Recebendo';
      case GroupStatus.paying:
        return 'A pagar';
      case GroupStatus.pending:
        return 'Pendente';
      case GroupStatus.finished:
        return 'Finalizado';
    }
  }

  static List<Group> get mockGroups => [
        Group(
          id: '1',
          name: 'Viagem p/ Búzios',
          category: 'Viagem',
          totalBalance: 2450.80,
          youOwe: 120.0,
          youReceive: 450.0,
          members: ['Você', 'Marina', 'Lucas', 'Ana', 'Pedro', 'Carla', 'João', 'Beto'],
          status: GroupStatus.receiving,
          statusDetail: 'Vence em 12 dias',
          yourPart: 450.0,
        ),
        Group(
          id: '2',
          name: 'Churrasco Mensal',
          category: 'Restaurante',
          totalBalance: 890.0,
          youOwe: 125.90,
          youReceive: 0.0,
          members: List.generate(12, (i) => 'Membro ${i + 1}'),
          status: GroupStatus.paying,
          statusDetail: 'Vence hoje',
          yourPart: 125.90,
        ),
        Group(
          id: '3',
          name: 'Aluguel do Campo',
          category: 'Esporte',
          totalBalance: 0.0,
          members: ['Você', 'Carlos', 'Rafael', 'Bruno', 'Thiago'],
          status: GroupStatus.pending,
          statusDetail: 'Aguardando confirmação de 3 pessoas para fechar o grupo.',
          pendingProgress: 0.7,
          yourPart: 0.0,
        ),
        Group(
          id: '4',
          name: 'Assinatura PS Plus',
          category: 'Jogos',
          totalBalance: 66.0,
          members: ['Você', 'Carlos', 'Rafael'],
          status: GroupStatus.receiving,
          statusDetail: 'Recorrente',
          yourPart: 22.0,
        ),
        Group(
          id: '5',
          name: 'Presente da Maria',
          category: 'Presente',
          totalBalance: 200.0,
          members: ['Você', 'Ana', 'Pedro'],
          status: GroupStatus.finished,
          statusDetail: 'Finalizado há 3 dias',
          yourPart: 0.0,
        ),
      ];
}
