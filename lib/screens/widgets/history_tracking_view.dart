import 'package:flutter/material.dart';
import '../../models/location_summary_model.dart';
import '../../utils/constants.dart';
import '../../utils/helper_functions.dart';
import 'location_history_card.dart';

class TrackingHistoryView extends StatelessWidget {
  final List<LocationSummaryModel> history;

  const TrackingHistoryView({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    if (history.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'No tracking history yet.',
              style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.tertiary, fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final entry = history[index];
        final arrival = entry.arrivalTime ?? DateTime.now();
        final departure = entry.departTime ?? DateTime.now();

        final duration = departure.difference(arrival);
        final formattedDuration = duration.isNegative ? 'N/A' : HelperFunctions().formatDuration(duration);
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: LocationHistoryCard(
            locationName: entry.locationName,
            startTime: arrival,
            endTime: departure,
            formattedDuration: formattedDuration,
            date: AppKeys.dateFormat.format(arrival),
            timeRange: '${AppKeys.timeFormat.format(arrival)} - ${AppKeys.timeFormat.format(departure)}',
            ),
          );
      },
    );
  }
}
