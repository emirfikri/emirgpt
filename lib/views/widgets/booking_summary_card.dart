import 'dart:isolate';

import '/core/helpers.dart';
import 'package:flutter/material.dart';

import '../../models/export_models.dart';

class BookingSummaryCard extends StatelessWidget {
  final VenuePromptConfirmation venuePromptConfirmation;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool? isAnswered;

  const BookingSummaryCard({
    super.key,
    required this.venuePromptConfirmation,
    this.onConfirm,
    this.onCancel,
    this.isAnswered,
  });

  @override
  Widget build(BuildContext context) {
    final venueName = venuePromptConfirmation.venueName;
    final startDate = Helpers.toUtcPlus8(venuePromptConfirmation.startDate);
    final endDate = Helpers.toUtcPlus8(venuePromptConfirmation.endDate);
    final cost =
        venuePromptConfirmation.pricePerHour; // Use the venue price per hour

    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Booking Summary',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Divider(height: 24),
          _buildRow(Icons.stadium, 'Venue', venueName),
          const SizedBox(height: 12),
          _buildRow(
            Icons.calendar_today,
            'Date',
            Helpers.formatDate(startDate),
          ),
          const SizedBox(height: 12),
          _buildRow(
            Icons.access_time,
            'Time',
            '${Helpers.formatTime(startDate)} - ${Helpers.formatTime(endDate)}',
          ),
          const SizedBox(height: 12),
          _buildRow(Icons.monetization_on, 'Cost', '$cost BP'),
          if (isAnswered == false) ...[
            const Divider(height: 24),
            const Text(
              'Please confirm your booking details.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade600),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
