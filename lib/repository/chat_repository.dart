import '../../../core/network/api_client.dart';

class ChatRepository {
  final ApiClient apiClient;

  ChatRepository(this.apiClient);

  Future<String> sendMessage(String message) {
    return apiClient.sendMessage(message);
  }
}
