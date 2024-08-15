import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget imageErrorBuilder(
    BuildContext context, String error, Object? stackTrace) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.broken_image,
          color: Colors.orangeAccent,
          size: 60,
        ),
        const SizedBox(height: 16),
        Text(
          "Oops! Something went wrong.",
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "We couldn't load the image.",
          style: GoogleFonts.openSans(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 16),
        // ElevatedButton(
        //   onPressed: () {
        //     // Implement a retry mechanism or any other action
        //   },
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.orangeAccent,
        //     foregroundColor: Colors.white,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(8),
        //     ),
        //   ),
        //   child: const Text("Try Again"),
        // ),
      ],
    ),
  );
}
