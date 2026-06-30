import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'state/app_state.dart';
import 'screens/screen_router.dart';

void main() {
  runApp(const WapdaCityApp());
}

class WapdaCityApp extends StatelessWidget {
  const WapdaCityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: Consumer<AppState>(
        builder: (context, state, _) {
          return MaterialApp(
            title: 'WAPDA City',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: GoogleFonts.poppins().fontFamily,
              colorScheme: ColorScheme.light(primary: state.colors.primary),
              scaffoldBackgroundColor: state.colors.bg,
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
            ),
            home: const ScreenRouter(),
          );
        },
      ),
    );
  }
}
