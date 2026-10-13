import 'dart:math';

import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../theme/game_colors.dart';
import 'game_button.dart';
import 'game_text.dart';

/// Smoothly animated pill progress bar with gloss.
class GameProgressBar extends StatelessWidget {
  final double value;
  final double height;
  final Color fill;
  final Color track;
  final String? label;

  const GameProgressBar({
    super.key,
    required this.value,
    this.height = 22,
    this.fill = GameColors.green,
    this.track = const Color(0x55000000),
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: value.clamp(0, 1)),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, v, _) => Container(
        height: height,
        decoration: BoxDecoration(
          color: track,
          borderRadius: BorderRadius.circular(height),
          border: Border.all(color: Colors.white.withValues(alpha: 0.8), width: 2),
        ),
        child: Stack(
          children: [
            FractionallySizedBox(
              widthFactor: max(v, 0.001),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color.lerp(fill, Colors.white, 0.35)!, fill],
                  ),
                  borderRadius: BorderRadius.circular(height),
                ),
              ),
            ),
            if (label != null) Center(child: GameText(label!, size: height * 0.62, strokeWidth: 3)),
          ],
        ),
      ),
    );
  }
}

/// 1–3 stars. When [animate] is set, earned stars pop in one by one.
class StarDisplay extends StatefulWidget {
  final int stars;
  final int max;
  final double size;
  final bool animate;
  final bool arc;
  final ValueChanged<int>? onStarShown;

  const StarDisplay({
    super.key,
    required this.stars,
    this.max = 3,
    this.size = 22,
    this.animate = false,
    this.arc = false,
    this.onStarShown,
  });

  @override
  State<StarDisplay> createState() => _StarDisplayState();
}

class _StarDisplayState extends State<StarDisplay> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 450 * widget.max + 300),
  );
  int _announced = 0;

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _c.addListener(_announce);
      Future.delayed(const Duration(milliseconds: 250), () {
        if (mounted) _c.forward();
      });
    } else {
      _c.value = 1;
    }
  }

  void _announce() {
    for (var i = _announced; i < widget.stars; i++) {
      if (_c.value * widget.max * 1.1 > i + 0.2) {
        _announced = i + 1;
        widget.onStarShown?.call(_announced);
      }
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [for (var i = 0; i < widget.max; i++) _star(i)],
      ),
    );
  }

  Widget _star(int i) {
    final earned = i < widget.stars;
    final local = ((_c.value * widget.max * 1.1) - i).clamp(0.0, 1.0);
    final scale = earned ? Curves.elasticOut.transform(local) : 1.0;
    final big = widget.arc && i == 1;
    final s = widget.size * (big ? 1.3 : 1);
    return Padding(
      padding: EdgeInsets.only(left: 2, right: 2, bottom: widget.arc && !big ? 0 : (widget.arc ? s * 0.25 : 0)),
      child: SizedBox(
        width: s,
        height: s,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.star_rounded,
              size: s,
              color: GameColors.starEmpty,
              shadows: const [Shadow(color: GameColors.inkSoft, offset: Offset(0, 1.5))],
            ),
            if (earned)
              Transform.scale(
                scale: scale,
                child: Icon(
                  Icons.star_rounded,
                  size: s,
                  color: GameColors.star,
                  shadows: const [Shadow(color: GameColors.goldDark, offset: Offset(0, 2))],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Chunky on/off switch.
class GameToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const GameToggle({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final loc = context.services.loc;
    return Semantics(
      toggled: value,
      child: Pressable(
        onTap: () => onChanged(!value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: 92,
          height: 44,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: value ? GameColors.green : GameColors.grey,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: value ? GameColors.greenDark : GameColors.greyDark, width: 2.5),
            boxShadow: [BoxShadow(color: value ? GameColors.greenDark : GameColors.greyDark, offset: const Offset(0, 3))],
          ),
          child: Stack(
            children: [
              Align(
                alignment: value ? Alignment.centerLeft : Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    value ? loc.t('common.on') : loc.t('common.off'),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12),
                  ),
                ),
              ),
              AnimatedAlign(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutBack,
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.25), offset: const Offset(0, 2), blurRadius: 2),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageSelector extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  const LanguageSelector({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final loc = context.services.loc;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final code in const ['en', 'tr'])
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Pressable(
              onTap: () => onChanged(code),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: value == code ? GameColors.blue : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: value == code ? GameColors.blueDark : GameColors.panelBorder, width: 2.5),
                ),
                child: Text(
                  loc.t('lang.$code'),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                    color: value == code ? Colors.white : GameColors.ink,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Original default avatars: gradient badge + glyph.
class AvatarDef {
  final String id;
  final IconData icon;
  final Color a, b;
  const AvatarDef(this.id, this.icon, this.a, this.b);
}

const avatars = <AvatarDef>[
  AvatarDef('fox', Icons.pets, Color(0xFFFFB35C), Color(0xFFF06A2A)),
  AvatarDef('cat', Icons.emoji_nature, Color(0xFFB8A6FF), Color(0xFF7550E8)),
  AvatarDef('bunny', Icons.cruelty_free, Color(0xFFFFB6D5), Color(0xFFE85C9A)),
  AvatarDef('bird', Icons.flutter_dash, Color(0xFF8FD8FF), Color(0xFF2E8FE0)),
  AvatarDef('bee', Icons.hive, Color(0xFFFFE27A), Color(0xFFE8A91E)),
  AvatarDef('star', Icons.star_rounded, Color(0xFFFFD66B), Color(0xFFFF8F3C)),
  AvatarDef('rocket', Icons.rocket_launch, Color(0xFF9DE7C3), Color(0xFF2DAE7A)),
  AvatarDef('leaf', Icons.eco, Color(0xFFB9F07A), Color(0xFF4DAA2C)),
];

AvatarDef avatarById(String id) => avatars.firstWhere((a) => a.id == id, orElse: () => avatars.first);

class ProfileAvatar extends StatelessWidget {
  final String avatarId;
  final double size;
  final bool selected;
  const ProfileAvatar({super.key, required this.avatarId, this.size = 48, this.selected = false});

  @override
  Widget build(BuildContext context) {
    final a = avatarById(avatarId);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [a.a, a.b]),
        border: Border.all(color: selected ? GameColors.gold : Colors.white, width: size * (selected ? 0.09 : 0.07)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 4, offset: const Offset(0, 3))],
      ),
      child: Icon(
        a.icon,
        color: Colors.white,
        size: size * 0.52,
        shadows: [Shadow(color: Colors.black.withValues(alpha: 0.25), offset: const Offset(0, 2))],
      ),
    );
  }
}

/// Small rounded counter chip (stars / score) used in headers.
class CounterChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  const CounterChip({super.key, required this.icon, required this.text, this.iconColor = GameColors.star});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 4, 14, 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.7), width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 26,
            shadows: const [Shadow(color: GameColors.goldDark, offset: Offset(0, 2))],
          ),
          const SizedBox(width: 4),
          GameText(text, size: 17, strokeWidth: 3),
        ],
      ),
    );
  }
}

/// Transient banner at the top of the screen.
void showGameToast(BuildContext context, String title, {String? message, IconData icon = Icons.info_rounded}) {
  final overlay = Overlay.maybeOf(context, rootOverlay: true);
  if (overlay == null) return;
  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (ctx) => _Toast(title: title, message: message, icon: icon, onDone: () => entry.remove()),
  );
  overlay.insert(entry);
}

class _Toast extends StatefulWidget {
  final String title;
  final String? message;
  final IconData icon;
  final VoidCallback onDone;
  const _Toast({required this.title, required this.message, required this.icon, required this.onDone});

  @override
  State<_Toast> createState() => _ToastState();
}

class _ToastState extends State<_Toast> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 2600))
    ..forward().whenComplete(widget.onDone);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, child) {
        final t = _c.value;
        final inT = Curves.easeOutBack.transform((t / 0.15).clamp(0, 1));
        final outT = ((t - 0.85) / 0.15).clamp(0.0, 1.0);
        return Positioned(
          top: MediaQuery.of(context).padding.top + 12 - 30 * (1 - inT) - 30 * outT,
          left: 20,
          right: 20,
          child: IgnorePointer(
            child: Opacity(opacity: (inT * (1 - outT)).clamp(0, 1), child: child),
          ),
        );
      },
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: GameColors.cream,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: GameColors.panelBorder, width: 4),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 6))],
          ),
          child: Material(
            type: MaterialType.transparency,
            child: Row(
              children: [
                Icon(widget.icon, color: GameColors.orange, size: 34),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: GameColors.ink),
                      ),
                      if (widget.message != null)
                        Text(
                          widget.message!,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: GameColors.inkSoft),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Horizontal shake used for locked-content feedback.
class ShakeController extends ChangeNotifier {
  void shake() => notifyListeners();
}

class Shake extends StatefulWidget {
  final ShakeController controller;
  final Widget child;
  const Shake({super.key, required this.controller, required this.child});

  @override
  State<Shake> createState() => _ShakeState();
}

class _ShakeState extends State<Shake> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_go);
  }

  void _go() => _c.forward(from: 0);

  @override
  void dispose() {
    widget.controller.removeListener(_go);
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _c,
    builder: (context, child) =>
        Transform.translate(offset: Offset(sin(_c.value * pi * 6) * 9 * (1 - _c.value), 0), child: child),
    child: widget.child,
  );
}
