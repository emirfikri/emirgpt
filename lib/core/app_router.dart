import 'package:go_router/go_router.dart';
import '../views/export_pages.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const ChatPage()),
    GoRoute(path: '/booking', builder: (_, __) => const BookingSplashPage()),
    GoRoute(path: '/booking-main', builder: (_, __) => const BookingPage()),
    GoRoute(
      path: '/resume-matcher',
      builder: (_, __) => const ResumeMatcherPage(),
    ),
  ],
);
