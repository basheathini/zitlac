import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zitlac/providers/location_tracking_provider.dart';
import 'package:zitlac/screens/tracking_screen.dart';
import 'package:zitlac/utils/constants.dart';
import 'injection_container.dart';

void main() async {
  await init();
  runApp(const ZitLackTrackingApp());
}

class ZitLackTrackingApp extends StatelessWidget {
  const ZitLackTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TrackingProvider>(
          create: (context) {
            final provider = TrackingProvider();
            return provider;
          },
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xff212529),
          scaffoldBackgroundColor: Color(0xfff5f6f7),
          canvasColor: Color(0xfff5f6f7),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Color(0xfff5f6f7),
            secondary: const Color(0xFF131F34),
            tertiary: const Color(0xFF667085),
          ),
          textTheme: const TextTheme(
            titleMedium: TextStyle(
              fontWeight: FontWeight.w600,
              height: 1.1,
              fontSize: 22,
              letterSpacing: 0.4,
            ),
            titleSmall: TextStyle(
              fontWeight: FontWeight.w600,
              height: 1.1,
              fontSize: 16,
              letterSpacing: 0.24,
            ),
            bodyMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              height: 1.15,
              letterSpacing: 0.4,
            ),
            bodySmall: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              height: 1.15,
              letterSpacing: 0.4,
            ),
          ),
        ),
        title: AppKeys.appName,
        debugShowCheckedModeBanner: false,
        home: const TrackingScreen(),
      ),
    );
  }
}
