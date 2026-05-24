import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/add_day_circle.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/add_new_place.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({super.key});

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.125).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String label,
    required bool hasBorder,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
        _toggleMenu();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xffFEEFE2),
          borderRadius: BorderRadius.circular(16),
          border: hasBorder
              ? Border.all(color: const Color(0xffDC9262), width: 1.5)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xffDC9262), size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xffDC9262),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainButton() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final Color bgColor = Color.lerp(
          AppColors.kPrimaryColor,
          const Color(0xffFEEFE2),
          _expandAnimation.value,
        )!;

        final Color iconColor = Color.lerp(
          Colors.white,
          const Color(0xffDC9262),
          _expandAnimation.value,
        )!;

        final double shadowOpacity = 1.0 - _expandAnimation.value;

        return GestureDetector(
          onTap: _toggleMenu,
          child: CustomPaint(
            painter: DashedCirclePainter(
              color: const Color(
                0xffDC9262,
              ).withOpacity(_expandAnimation.value),
              strokeWidth: 1.5,
              dashWidth: 5.0,
              dashSpace: 3.0,
            ),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
                boxShadow: shadowOpacity > 0
                    ? [
                        BoxShadow(
                          color: AppColors.kShadowColor.withOpacity(
                            AppColors.kShadowColor.opacity * shadowOpacity,
                          ),
                          blurRadius: 20,
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: RotationTransition(
                  turns: _rotationAnimation,
                  child: Icon(Icons.add, size: 24, color: iconColor),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizeTransition(
          sizeFactor: _expandAnimation,
          axisAlignment: 1.0,
          child: FadeTransition(
            opacity: _expandAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildOptionButton(
                  icon: Icons.location_on_outlined,
                  label: 'Add Place',
                  hasBorder: false,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return AddNewPlace();
                      },
                    );
                  },
                ),
                const SizedBox(height: 12),
                _buildOptionButton(
                  icon: Icons.delete_outline_rounded,
                  label: 'Delete Place',
                  hasBorder: false,
                  onTap: () {
                    // TODO: Action for Delete Place
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        _buildMainButton(),
      ],
    );
  }
}

