import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zitlac/screens/widgets/history_tracking_view.dart';
import 'package:zitlac/screens/widgets/tracking_status_indicator.dart';
import '../providers/location_tracking_provider.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tracker = Provider.of<TrackingProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black87, Colors.transparent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: TabBar(
                            labelColor: Theme.of(context).colorScheme.secondary,
                            unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
                            indicatorColor: Theme.of(context).colorScheme.secondary,
                            indicatorWeight: 2.5,
                            labelStyle: Theme.of(context).textTheme.titleSmall,
                            isScrollable: true,
                            tabs: const [
                              Tab(text: 'Tracking',),
                              Tab(text: 'History'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          TrackingStatusIndicator(isTracking: tracker.isTracking),
                          TrackingHistoryView(history: tracker.trackingHistory),
                        ],
                      ),
                    ),
                  ],
                ),
                ListenableBuilder(
                  listenable: DefaultTabController.of(context),
                  builder: (context, _) {
                    final tabController = DefaultTabController.of(context);
                    return Visibility(
                      visible: tabController.index == 0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: ElevatedButton(
                            onPressed: ()  {
                              tracker.toggleTracking();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(32),
                              backgroundColor:  tracker.isTracking ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.secondary,
                              elevation: 6,
                              shadowColor: Theme.of(context).colorScheme.tertiary,
                            ),
                            child: Text(
                              tracker.isTracking ? 'STOP' : 'START',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
