import 'package:flutter/material.dart';

class TrackingStatusIndicator extends StatelessWidget {
  final bool isTracking;

  const TrackingStatusIndicator({
    super.key,
    required this.isTracking,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Column(
          key: ValueKey<bool>(isTracking),
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  isTracking ? 'Tap stop to end tracking.' : 'Tap start to begin tracking.',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.tertiary, fontWeight: FontWeight.bold
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}