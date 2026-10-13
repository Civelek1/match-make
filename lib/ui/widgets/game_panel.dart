import 'dart:ui';

import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../theme/game_colors.dart';
import 'game_button.dart';
import 'game_text.dart';

/// Cream card with a thick warm border and an optional ribbon title.
class GamePanel extends StatelessWidget {
  final Widget child;
  final String? title;
  final Color ribbon;
  final EdgeInsets padding;
  final VoidCallback? onClose;
  final double maxWidth;

  const GamePanel({
    super.key,
    required this.child,
    this.title,
    this.ribbon = GameColors.orange,
    this.padding = const EdgeInsets.fromLTRB(20, 34, 20, 20),
    this.onClose,
    this.maxWidth = 420,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: EdgeInsets.only(top: title == null ? 0 : 22),
            padding: title == null ? padding.copyWith(top: 20) : padding,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFFCF4), GameColors.cream],
              ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: GameColors.panelBorder, width: 5),
              boxShadow: [
                const BoxShadow(color: Color(0xFFC98E4B), offset: Offset(0, 7)),
                BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 24, offset: const Offset(0, 14)),
              ],
            ),
            child: child,
          ),
          if (title != null)
            Positioned(
              top: 0,
              left: 30,
              right: 30,
              child: Center(
                child: Ribbon(text: title!, color: ribbon),
              ),
            ),
          if (onClose != null)
            Positioned(
              top: title == null ? -12 : 8,
              right: -10,
              child: GameIconButton(
                icon: Icons.close_rounded,
                tone: ButtonTone.red,
                size: 44,
                semanticLabel: context.services.loc.t('common.close'),
                onTap: onClose,
              ),
            ),
        ],
      ),
    );
  }
}

class Ribbon extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  const Ribbon({super.key, required this.text, this.color = GameColors.orange, this.fontSize = 24});

  @override
  Widget build(BuildContext context) {
    final dark = Color.lerp(color, Colors.black, 0.3)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.lerp(color, Colors.white, 0.3)!, color],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: dark, width: 3),
        boxShadow: [BoxShadow(color: dark, offset: const Offset(0, 4))],
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: GameText(text, size: fontSize, stroke: dark, strokeWidth: 5),
      ),
    );
  }
}

/// Shows a modal with dim + blur backdrop and a bouncy scale-in.
Future<T?> showGameModal<T>(BuildContext context, {required WidgetBuilder builder, bool dismissible = true}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: dismissible,
    barrierLabel: 'modal',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 380),
    pageBuilder: (ctx, a1, a2) => builder(ctx),
    transitionBuilder: (ctx, anim, _, child) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutBack, reverseCurve: Curves.easeIn);
      return Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4 * anim.value, sigmaY: 4 * anim.value),
                child: ColoredBox(color: Colors.black.withValues(alpha: 0.45 * anim.value)),
              ),
            ),
          ),
          FadeTransition(
            opacity: anim,
            child: ScaleTransition(scale: Tween(begin: 0.8, end: 1.0).animate(curved), child: child),
          ),
        ],
      );
    },
  );
}

/// Standard yes/no confirmation.
Future<bool> showConfirmModal(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  required String cancelLabel,
  ButtonTone confirmTone = ButtonTone.red,
}) async {
  final r = await showGameModal<bool>(
    context,
    builder: (ctx) => Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Material(
          type: MaterialType.transparency,
          child: GamePanel(
            title: title,
            ribbon: confirmTone == ButtonTone.red ? GameColors.red : GameColors.orange,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BodyText(message, size: 17),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: GameButton.secondary(
                        label: cancelLabel,
                        tone: ButtonTone.blue,
                        onTap: () => Navigator.of(ctx).pop(false),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GameButton.secondary(
                        label: confirmLabel,
                        tone: confirmTone,
                        onTap: () => Navigator.of(ctx).pop(true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  return r ?? false;
}
