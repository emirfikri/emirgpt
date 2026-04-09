import 'package:flutter/material.dart';
import 'package:emirgpt/blocs/export_blocs.dart';
import 'package:emirgpt/core/helpers.dart';

class BookingListPage extends StatefulWidget {
  final ScrollController? scrollController;

  const BookingListPage({super.key, this.scrollController});

  @override
  State<BookingListPage> createState() => _BookingListPageState();
}

class _BookingListPageState extends State<BookingListPage> {
  @override
  void initState() {
    super.initState();
    // Load booking history when page initializes
    context.read<BookingListCubit>().initializeWithUser();

    context.read<BookingListCubit>().loadBookingHistory();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingListCubit, BookingListState>(
      builder: (context, state) {
        // Show loading indicator
        if (state.isLoadingHistory) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show error message
        if (state.historyError != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  state.historyError!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<BookingListCubit>().refreshBookingHistory();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        // Show empty state
        if (state.bookingHistory.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                const Text(
                  'No bookings yet',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your bookings will appear here',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Go back to chat
                  },
                  child: const Text('Create a Booking'),
                ),
              ],
            ),
          );
        }

        // Show booking list
        return RefreshIndicator(
          onRefresh: () =>
              context.read<BookingListCubit>().refreshBookingHistory(),
          child: ListView.builder(
            controller: widget.scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: state.bookingHistory.length,
            itemBuilder: (context, index) {
              final booking = state.bookingHistory[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: Container(
                    decoration: BoxDecoration(
                      color: _getStatusColor(booking.status),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      _getStatusIcon(booking.status),
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    booking.venueName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        Helpers.formatDateWithMonthName(booking.bookingDate),
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Status: ${booking.status}',
                        style: TextStyle(
                          fontSize: 12,
                          color: _getStatusColor(booking.status),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: navigate to booking details
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Icons.check_circle;
      case 'completed':
        return Icons.done_all;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }
}
