import 'package:flutter/material.dart';

class BookingListPage extends StatelessWidget {
  final ScrollController? scrollController;

  const BookingListPage({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: 25,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            title: Text('Booking #${index + 1}'),
            subtitle: const Text('Upcoming confirmed booking details.'),
            leading: const Icon(Icons.event_available),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: navigate to booking details if needed
            },
          ),
        );
      },
    );
  }
}
