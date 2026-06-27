import 'dart:async';
import 'package:explore_egypt/features/chat/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';

class VoiceCallScreen extends StatefulWidget {
  const VoiceCallScreen({super.key});

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen>
    with TickerProviderStateMixin {
  // ── REMOVED: dead _recorder field that was never used ──

  bool _isCallActive = false;
  bool _isEnding = false;
  String _status = 'Connecting...';
  int _seconds = 0;
  Timer? _timer;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _pulse2Controller;
  late Animation<double> _pulse2Animation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.18).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _pulse2Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
    _pulse2Animation = Tween<double>(begin: 1.0, end: 1.32).animate(
      CurvedAnimation(parent: _pulse2Controller, curve: Curves.easeInOut),
    );

    _startCall();
  }

  Future<void> _startCall() async {
    final cubit = context.read<ChatCubit>();
    if (!cubit.isCallActive) {
      cubit.startVoiceCall();
    }

    // FIX: guard every setState with mounted check because this method is async
    if (!mounted) return;
    setState(() {
      _isCallActive = true;
      _status = 'Listening to you...';
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _seconds++);
    });
  }

  Future<void> _endCall() async {
    // FIX: early return if already ending — prevents double-invocation
    if (_isEnding) return;

    _timer?.cancel();

    setState(() {
      _isEnding = true;
      _status = 'Call ended';
      _isCallActive = false;
    });

    _pulseController.stop();
    _pulse2Controller.stop();

    context.read<ChatCubit>().endVoiceCall();

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) Navigator.pop(context);
  }

  String get _formattedTime {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    _pulse2Controller.dispose();
    // FIX: removed _recorder.dispose() — field deleted
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FIX: wrap in BlocListener to catch ChatError and auto-end the call
    return BlocListener<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatError && !_isEnding) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red.shade800,
            ),
          );
          _endCall();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0F0F13),
        body: SafeArea(
          child: Column(
            children: [
              // ── Top bar ──────────────────────────────────────────
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    IconButton(
                      // FIX: use _isEnding guard (was already correct here)
                      onPressed: _isEnding ? null : _endCall,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white70,
                        size: 28,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _formattedTime,
                      style:
                          const TextStyle(color: Colors.white54, fontSize: 14),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              const Spacer(),

              Text(
                _isEnding ? 'Call ended' : 'AI Assistant',
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _status,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 60),

              // ── Avatar with pulse rings ──────────────────────────
              SizedBox(
                width: 220,
                height: 220,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (!_isEnding) ...[
                      AnimatedBuilder(
                        animation: _pulse2Animation,
                        builder: (_, __) => Transform.scale(
                          scale: _pulse2Animation.value,
                          child: Container(
                            width: 190,
                            height: 190,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  AppColors.kPrimaryColor.withOpacity(0.10),
                            ),
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (_, __) => Transform.scale(
                          scale: _pulseAnimation.value,
                          child: Container(
                            width: 155,
                            height: 155,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  AppColors.kPrimaryColor.withOpacity(0.18),
                            ),
                          ),
                        ),
                      ),
                    ],
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isEnding
                            ? Colors.grey.shade800
                            : AppColors.kPrimaryColor.withOpacity(0.85),
                      ),
                      child: Icon(
                        _isEnding
                            ? Icons.call_end
                            : Icons.smart_toy_outlined,
                        color: Colors.white,
                        size: 46,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              if (!_isEnding)
                _WaveformBars(
                  color: AppColors.kPrimaryColor,
                  isActive: _isCallActive,
                ),

              const Spacer(),

              if (!_isEnding)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // FIX: pass _isEnding into the button so it can guard itself
                      _EndCallButton(
                        onTap: _endCall,
                        isEnding: _isEnding,
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Waveform widget ──────────────────────────────────────────────────────────

class _WaveformBars extends StatefulWidget {
  const _WaveformBars({required this.color, required this.isActive});
  final Color color;
  final bool isActive;

  @override
  State<_WaveformBars> createState() => _WaveformBarsState();
}

class _WaveformBarsState extends State<_WaveformBars>
    with TickerProviderStateMixin {
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    final delays = [0, 100, 200, 300, 200, 100, 0];
    for (int i = 0; i < 7; i++) {
      final c = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 900),
      );
      _controllers.add(c);
      _animations.add(
        Tween<double>(begin: 8, end: 32).animate(
          CurvedAnimation(parent: c, curve: Curves.easeInOut),
        ),
      );
      // FIX: only start animating when isActive; delay still applies
      if (widget.isActive) {
        Future.delayed(Duration(milliseconds: delays[i]), () {
          if (mounted) c.repeat(reverse: true);
        });
      }
    }
  }

  @override
  void didUpdateWidget(_WaveformBars oldWidget) {
    super.didUpdateWidget(oldWidget);
    // FIX: react to isActive changes — stop or start controllers accordingly
    if (oldWidget.isActive != widget.isActive) {
      for (final c in _controllers) {
        if (widget.isActive) {
          c.repeat(reverse: true);
        } else {
          c.stop();
        }
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(7, (i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: AnimatedBuilder(
              animation: _animations[i],
              builder: (_, __) => Container(
                width: 4,
                height: widget.isActive ? _animations[i].value : 8,
                decoration: BoxDecoration(
                  color: widget.color
                      .withOpacity(widget.isActive ? 0.85 : 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ── Reusable button widgets ──────────────────────────────────────────────────

class _EndCallButton extends StatelessWidget {
  const _EndCallButton({required this.onTap, required this.isEnding});
  final VoidCallback onTap;
  // FIX: added isEnding so GestureDetector can guard against double-tap
  final bool isEnding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // FIX: was always live before; now respects _isEnding state
      onTap: isEnding ? null : onTap,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.kPrimaryColor,
            ),
            child: const Icon(Icons.close_rounded,
                color: Colors.white, size: 30),
          ),
          const SizedBox(height: 8),
          const Text(
            'End call',
            style: TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ],
      ),
    );
  }
}