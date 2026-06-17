import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final String title;
  final String content;
  const DeleteConfirmationDialog({super.key, required this.onConfirm, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(
        0xffFFF7ED,
      ), // Matches your UI canvas background color tint
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        title,
        style: GoogleFonts.inter(
          color: const Color(0xff43281C),
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      content: Text(
        content,
        style: GoogleFonts.inter(
          color: const Color(0xff43281C).withValues(alpha: 0.8),
          fontSize: 14,
        ),
      ),
      actionsPadding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
      actions: [
        Row(
          children: [
            // Cancel Button
            Expanded(
              child: TextButton(
                onPressed: () =>
                    Navigator.pop(context), // Closes the dialog safely
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.inter(
                    color: const Color(0xffAF5D48),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Confirm Delete Button
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog box safely
                  onConfirm(); // Fire the actual deletion callback function
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xffC1514C,
                  ), // Your signature brand red-orange shade
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Delete',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
