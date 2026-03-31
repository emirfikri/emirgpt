import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookingSplashPage extends StatefulWidget {
  const BookingSplashPage({super.key});

  @override
  State<BookingSplashPage> createState() => _BookingSplashPageState();
}

class _BookingSplashPageState extends State<BookingSplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToBooking();
  }

  void _navigateToBooking() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go('/booking-main');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.7),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.event_available, size: 80, color: Colors.white),
              const SizedBox(height: 32),
              const Text(
                'BookingGPT',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Venue Booking Assistant',
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const SizedBox(height: 48),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
