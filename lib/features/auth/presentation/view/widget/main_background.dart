import 'package:explore_egypt/core/widgets/background.dart';
import 'package:explore_egypt/core/widgets/custom_wave_shape.dart';
import 'package:flutter/material.dart';

class MainBackground extends StatelessWidget {
  const MainBackground({
    super.key,
    required this.child
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenHeight = MediaQuery.of(context).size.height;
        final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        
        // Detect if keyboard is open by checking either bottom inset (when resizeToAvoidBottomInset is false)
        // or if layout constraints height shrunk significantly (when resizeToAvoidBottomInset is true)
        final bool isKeyboardOpen = keyboardHeight > 0 || (constraints.maxHeight < screenHeight - 150);
        final double topOffset = isKeyboardOpen ? -60.0 : 0.0;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Forces the Stack to take up the full available height of the parent constraints
            const SizedBox.expand(),
            BackGround(),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              top: topOffset,
              left: 0,
              right: 0,
              height: screenHeight,
              child: const CustomWaveShape(),
            ),
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  // Center the form content inside the viewport height
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: child,
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}
