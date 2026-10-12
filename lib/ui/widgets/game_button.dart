import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../../audio/audio_service.dart';
import '../theme/game_colors.dart';
import 'game_text.dart';

enum ButtonTone { green, blue, orange, red, purple, cream }

class _Tone {
  final Color top, bottom, lip, border;
  final Color textStroke;
  const _Tone(this.top, this.bottom, this.lip, this.border, this.textStroke);
}

const _tones = {
  ButtonTone.green: _Tone(Color(0xFF8BE36B), GameColors.green, GameColors.greenDark, Color(0xFF25802C), Color(0xFF1E6B25)),
  ButtonTone.blue: _Tone(Color(0xFF7CC8FF), GameColors.blue, GameColors.blueDark, Color(0xFF1B5FAE), Color(0xFF16508F)),
  ButtonTone.orange: _Tone(Color(0xFFFFC15E), GameColors.orange, GameColors.orangeDark, Color(0xFFC04F12), Color(0xFFA2400C)),
  ButtonTone.red: _Tone(Color(0xFFFF8E98), GameColors.red, GameColors.redDark, Color(0xFFB02339), Color(0xFF8E1B2E)),
  ButtonTone.purple: _Tone(Color(0xFFC3A2FF), GameColors.purple, GameColors.purpleDark, Color(0xFF5530B8), Color(0xFF45279A)),
  ButtonTone.cream: _Tone(Color(0xFFFFFFFF), GameColors.cream, GameColors.creamDark, GameColors.panelBorder, GameColors.ink),
};
const _disabled = _Tone(Color(0xFFD9D4E3), GameColors.grey, GameColors.greyDark, Color(0xFF7A7390), Color(0xFF6A6480));

/// Press-reactive wrapper: squash on press, bounce on release, click sound
/// and subtle haptic. Base for every tappable game control.
class Pressable extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool sound;
  final double pressedScale;
  const Pressable({super.key, required this.child, this.onTap, this.sound = true, this.pressedScale = 0.92});

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _down = false;

  void _set(bool v) {
    if (_down != v && mounted) setState(() => _down = v);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _set(true),
      onTapCancel: () => _set(false),
      onTapUp: (_) => _set(false),
      onTap: () {
        final s = context.services;
        if (widget.sound) {
          s.audio.play(widget.onTap == null ? Sfx.locked : Sfx.click);
          s.haptics.button();
        }
        widget.onTap?.call();
      },
      child: AnimatedScale(
        scale: _down ? widget.pressedScale : 1,
        duration: Duration(milliseconds: _down ? 70 : 220),
        curve: _down ? Curves.easeOut : Curves.elasticOut,
        child: widget.child,
      ),
    );
  }
}

/// Glossy 3D game button. `onTap == null` → disabled look; `locked` → padlock.
class GameButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final ButtonTone tone;
  final double height;
  final double? width;
  final double fontSize;
  final bool locked;

  const GameButton({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.tone = ButtonTone.green,
    this.height = 60,
    this.width,
    this.fontSize = 22,
    this.locked = false,
  });

  /// Large dominant call-to-action.
  const GameButton.primary({super.key, required this.label, this.onTap, this.icon, this.width, this.locked = false})
    : tone = ButtonTone.green,
      height = 72,
      fontSize = 30;

  const GameButton.secondary({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.width,
    this.tone = ButtonTone.blue,
    this.locked = false,
  }) : height = 54,
       fontSize = 18;

  @override
  State<GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onTap != null && !widget.locked;
    final t = enabled ? _tones[widget.tone]! : _disabled;
    final lip = widget.height * 0.1;
    final radius = widget.height * 0.36;
    final pressedLip = _down ? lip * 0.3 : lip;

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.locked) ...[
          Icon(Icons.lock_rounded, color: Colors.white, size: widget.fontSize * 1.05),
          SizedBox(width: widget.fontSize * 0.3),
        ] else if (widget.icon != null) ...[
          Icon(
            widget.icon,
            color: Colors.white,
            size: widget.fontSize * 1.15,
            shadows: [Shadow(color: t.textStroke, offset: const Offset(0, 2), blurRadius: 1)],
          ),
          SizedBox(width: widget.fontSize * 0.35),
        ],
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: GameText(
              widget.label,
              size: widget.fontSize,
              stroke: widget.tone == ButtonTone.cream && enabled ? Colors.white : t.textStroke,
              strokeWidth: widget.fontSize * 0.2,
              color: widget.tone == ButtonTone.cream && enabled ? GameColors.ink : Colors.white,
            ),
          ),
        ),
      ],
    );

    return Semantics(
      button: true,
      enabled: enabled,
      label: widget.label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => setState(() => _down = true),
        onTapCancel: () => setState(() => _down = false),
        onTapUp: (_) => setState(() => _down = false),
        onTap: () {
          final s = context.services;
          if (!enabled) {
            s.audio.play(Sfx.locked);
            if (widget.locked) widget.onTap?.call();
            return;
          }
          s.audio.play(Sfx.click);
          s.haptics.button();
          widget.onTap!();
        },
        child: AnimatedScale(
          scale: _down ? 0.95 : 1,
          duration: Duration(milliseconds: _down ? 60 : 260),
          curve: _down ? Curves.easeOut : Curves.elasticOut,
          child: SizedBox(
            height: widget.height + lip,
            width: widget.width,
            child: Stack(
              children: [
                // Lip / 3D bottom.
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: widget.height,
                  child: Container(
                    decoration: BoxDecoration(
                      color: t.lip,
                      borderRadius: BorderRadius.circular(radius),
                      border: Border.all(color: t.border, width: 2.5),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.22), blurRadius: 8, offset: const Offset(0, 4)),
                      ],
                    ),
                  ),
                ),
                // Face.
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 60),
                  left: 0,
                  right: 0,
                  top: lip - pressedLip,
                  height: widget.height,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [t.top, t.bottom],
                      ),
                      borderRadius: BorderRadius.circular(radius),
                      border: Border.all(color: t.border, width: 2.5),
                    ),
                    child: Stack(
                      children: [
                        // Gloss highlight.
                        Positioned(
                          left: radius * 0.45,
                          right: radius * 0.45,
                          top: 3,
                          height: widget.height * 0.36,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: enabled ? 0.35 : 0.2),
                              borderRadius: BorderRadius.circular(radius),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: widget.height * 0.3),
                            child: content,
                          ),
                        ),
                      ],
                    ),
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

/// Round icon-only button (pause, back, close, settings...).
class GameIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final ButtonTone tone;
  final double size;
  final String? semanticLabel;

  const GameIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.tone = ButtonTone.blue,
    this.size = 50,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final t = onTap == null ? _disabled : _tones[tone]!;
    return Semantics(
      button: true,
      label: semanticLabel,
      child: Pressable(
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [t.top, t.bottom]),
            border: Border.all(color: t.border, width: 2.5),
            boxShadow: [
              BoxShadow(color: t.lip, offset: const Offset(0, 4)),
              BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 6, offset: const Offset(0, 6)),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: size * 0.08,
                child: Container(
                  width: size * 0.55,
                  height: size * 0.26,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(size),
                  ),
                ),
              ),
              Icon(
                icon,
                size: size * 0.55,
                color: tone == ButtonTone.cream ? GameColors.ink : Colors.white,
                shadows: [Shadow(color: t.textStroke, offset: const Offset(0, 2))],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
