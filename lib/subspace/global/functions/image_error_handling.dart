import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget imageErrorBuilder(
    BuildContext context, String error, Object? stackTrace) {
  return ConstrainedBox(
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.3,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
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
        const Spacer(),
        // ElevatedButton(
        //   onPressed: null,
        //  style: ElevatedButton.styleFrom(
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
