import 'package:flutter/material.dart';
import '../../blocs/export_blocs.dart';
import '../../core/helpers.dart';
import '../../models/export_models.dart';

class QuickActionWidget extends StatelessWidget {
  final SuggestedSlot suggestedSlot;
  final VoidCallback? onTap;

  const QuickActionWidget({super.key, required this.suggestedSlot, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => context.read<BookingChatCubit>().sendMessage(
        'Book me ${suggestedSlot.venueName} on ${Helpers.formatDate(suggestedSlot.startDate)} at ${Helpers.formatTime(Helpers.toUtcPlus8(suggestedSlot.startDate))}',
      ),
      label: Text(
        'Book ${suggestedSlot.venueName} on ${Helpers.formatDateWithMonthName(suggestedSlot.startDate)} at ${Helpers.formatTime(Helpers.toUtcPlus8(suggestedSlot.startDate))}',
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.green,
        elevation: 1.5,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}
