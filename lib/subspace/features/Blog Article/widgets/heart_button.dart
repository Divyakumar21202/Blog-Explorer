import 'package:flutter/material.dart';

class HeartButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onPressed;

  const HeartButton({
    super.key,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          12,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.1,
            ),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isSelected ? Icons.favorite : Icons.favorite_border,
                  size: 30,
                  color: Colors.black,
                ),
                if (isSelected) ...[
                  const SizedBox(width: 12),
                  Text(
                    'Liked',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
