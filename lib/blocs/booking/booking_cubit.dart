import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/network/booking_api_client.dart';
import '../../core/storage/booking_storage.dart';
import '../../models/export_models.dart';
import '../../repository/booking_repository.dart';
import 'booking_state.dart';

class BookingListCubit extends Cubit<BookingListState> {
  final BookingRepository repository;
  final BookingApiClient apiClient;
  User? currentUser;

  BookingListCubit(this.repository, this.apiClient)
    : super(const BookingInitial()) {
    final savedMessages = BookingStorage.load();
    print('Loaded saved messages: ${savedMessages.length}');
    if (savedMessages.isNotEmpty) {
      emit(BookingSuccess(savedMessages));
    }
  }

  void initializeWithUser() {
    //ser user) {
    // currentUser = user;
    currentUser = User(
      uid: '0234',
      userId: '0234',
      email: 'a@a.com',
      createdAt: DateTime.now(),
    );
  }

  Future<void> loadBookingHistory() async {
    if (currentUser == null) {
      emit(
        BookingHistoryError(
          'User not authenticated',
          state.messages,
          bookingHistory: state.bookingHistory,
        ),
      );
      return;
    }

    try {
      emit(
        BookingHistoryLoading(
          state.messages,
          bookingHistory: state.bookingHistory,
        ),
      );

      final history = await apiClient.getBookingHistory(user: currentUser!);
      emit(BookingHistoryLoaded(state.messages, history));
    } catch (e) {
      emit(
        BookingHistoryError(
          'Failed to load booking history: $e',
          state.messages,
          bookingHistory: state.bookingHistory,
        ),
      );
    }
  }

  Future<void> refreshBookingHistory() async {
    await loadBookingHistory();
  }
}
