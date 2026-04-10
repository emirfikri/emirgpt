import 'package:go_router/go_router.dart';
import '../views/export_pages.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, _) => const BookingSplashPage()),
    // GoRoute(path: '/booking', builder: (_, _) => const BookingSplashPage()),
    ShellRoute(
      builder: (context, state, child) => HomeMainPage(child: child),
      routes: [
        GoRoute(
          path: '/home/chat',
          builder: (context, state) => const BookingChatPage(),
          name: 'chat',
        ),
        GoRoute(
          path: '/home/bookings',
          builder: (context, state) => const BookingListPage(),
          name: 'bookings',
        ),
      ],
    ),
  ],
);
