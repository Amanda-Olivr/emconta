import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';

/// Reusable glass-morphism card widget
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final Color? borderLeftColor;
  final bool isDashed;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius = 24,
    this.borderLeftColor,
    this.isDashed = false,
  });

  @override
  Widget build(BuildContext context) {
    if (borderLeftColor != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.glassCardBg,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: AppTheme.glassCardBorder),
          ),
          child: Row(
            children: [
              Container(width: 4, color: borderLeftColor),
              Expanded(child: Padding(padding: padding, child: child)),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppTheme.glassCardBg,
        borderRadius: BorderRadius.circular(borderRadius),
        border: isDashed
            ? Border.all(color: AppTheme.outlineVariant, width: 2)
            : Border.all(color: AppTheme.glassCardBorder),
      ),
      child: child,
    );
  }
}

/// Status chip/badge
class StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const StatusChip({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        label,
        style: GoogleFonts.manrope(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
          color: color,
        ),
      ),
    );
  }
}

/// Mesh gradient hero card background
class MeshGradientCard extends StatelessWidget {
  final Widget child;

  const MeshGradientCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const RadialGradient(
          center: Alignment(-1.0, -1.0),
          radius: 2.0,
          colors: [
            Color(0xFFA078FF),
            Color(0xFF6D3BD7),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA078FF).withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative glow
          Positioned(
            right: -40,
            bottom: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            left: -20,
            top: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00F1FD).withOpacity(0.08),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

/// Label caps text style helper
class LabelCaps extends StatelessWidget {
  final String text;
  final Color? color;

  const LabelCaps(this.text, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
        color: color ?? AppTheme.outline,
      ),
    );
  }
}

/// Number display (Epilogue font)
class NumberDisplay extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;

  const NumberDisplay(
    this.text, {
    super.key,
    this.fontSize = 20,
    this.color,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.epilogue(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? AppTheme.onSurface,
        height: 1.0,
        letterSpacing: -0.5,
      ),
    );
  }
}
