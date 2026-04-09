import '../../models/export_models.dart';

abstract class BookingListState {
  final List<ChatMessage> messages;
  final List<BookingHistory> bookingHistory;
  final bool isLoadingHistory;
  final String? historyError;

  const BookingListState(
    this.messages, {
    this.bookingHistory = const [],
    this.isLoadingHistory = false,
    this.historyError,
  });
}

class BookingInitial extends BookingListState {
  const BookingInitial()
    : super(const [], bookingHistory: const [], isLoadingHistory: false);
}

class BookingLoading extends BookingListState {
  const BookingLoading(List<ChatMessage> messages)
    : super(messages, bookingHistory: const [], isLoadingHistory: false);
}

class BookingSuccess extends BookingListState {
  const BookingSuccess(
    List<ChatMessage> messages, {
    List<BookingHistory> bookingHistory = const [],
    bool isLoadingHistory = false,
    String? historyError,
  }) : super(
         messages,
         bookingHistory: bookingHistory,
         isLoadingHistory: isLoadingHistory,
         historyError: historyError,
       );
}

class BookingError extends BookingListState {
  final String error;

  const BookingError(
    this.error,
    List<ChatMessage> messages, {
    List<BookingHistory> bookingHistory = const [],
    bool isLoadingHistory = false,
    String? historyError,
  }) : super(
         messages,
         bookingHistory: bookingHistory,
         isLoadingHistory: isLoadingHistory,
         historyError: historyError,
       );
}

class BookingStreaming extends BookingListState {
  const BookingStreaming(
    List<ChatMessage> messages, {
    List<BookingHistory> bookingHistory = const [],
    bool isLoadingHistory = false,
    String? historyError,
  }) : super(
         messages,
         bookingHistory: bookingHistory,
         isLoadingHistory: isLoadingHistory,
         historyError: historyError,
       );
}

class UpdateMessages extends BookingListState {
  const UpdateMessages(
    List<ChatMessage> messages, {
    List<BookingHistory> bookingHistory = const [],
    bool isLoadingHistory = false,
    String? historyError,
  }) : super(
         messages,
         bookingHistory: bookingHistory,
         isLoadingHistory: isLoadingHistory,
         historyError: historyError,
       );
}

class BookingHistoryLoading extends BookingListState {
  const BookingHistoryLoading(
    List<ChatMessage> messages, {
    List<BookingHistory> bookingHistory = const [],
  }) : super(messages, bookingHistory: bookingHistory, isLoadingHistory: true);
}

class BookingHistoryLoaded extends BookingListState {
  const BookingHistoryLoaded(
    List<ChatMessage> messages,
    List<BookingHistory> bookingHistory,
  ) : super(messages, bookingHistory: bookingHistory, isLoadingHistory: false);
}

class BookingHistoryError extends BookingListState {
  final String error;

  const BookingHistoryError(
    this.error,
    List<ChatMessage> messages, {
    List<BookingHistory> bookingHistory = const [],
  }) : super(
         messages,
         bookingHistory: bookingHistory,
         isLoadingHistory: false,
         historyError: error,
       );
}
