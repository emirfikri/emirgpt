import 'package:flutter/material.dart';
import 'blocs/export_blocs.dart';
import 'core/app_router.dart';
import 'core/network/export_api.dart';
import 'firebase_options.dart';
import 'repository/export_repository.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// EmirGPT Chat
        BlocProvider(create: (_) => ChatCubit(ChatRepository(ApiClient()))),

        /// Booking Venue
        BlocProvider(
          create: (_) =>
              BookingChatCubit(BookingRepository(BookingApiClient())),
        ),

        BlocProvider(
          create: (_) => BookingListCubit(
            BookingRepository(BookingApiClient()),
            BookingApiClient(),
          ),
        ),

        /// Resume Matcher
        BlocProvider(
          create: (_) =>
              ResumeMatcherCubit(ResumeMatcherRepository(ResumeMatcherApi())),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        // initialRoute: '/',
        routerConfig: router,
      ),
    );
  }
}
