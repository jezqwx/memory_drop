import 'package:flutter/material.dart';

class AnimatedFavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onPressed;

  const AnimatedFavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: 24,
      icon: SizedBox(
        width: 30,
        height: 30,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Серый контур сердца
            const Icon(
              Icons.favorite_border,
              size: 28,
            ),

            // Красное сердце, которое растёт из центра
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 0,
                end: isFavorite ? 1 : 0,
              ),
              duration: const Duration(milliseconds: 250),
              curve: isFavorite
                  ? Curves.easeOutBack
                  : Curves.easeInBack,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: const Icon(
                Icons.favorite,
                size: 28,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}