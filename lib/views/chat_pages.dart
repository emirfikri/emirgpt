import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../blocs/export_blocs.dart';
import 'widgets/promptChip.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EmirGPT'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              context.read<ChatCubit>().clearHistory();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          /// Chat messages
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                final messages = state.messages;

                if (messages.isEmpty) {
                  if (messages.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'EmirGPT',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'How can I help you today?',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 32),

                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            alignment: WrapAlignment.center,
                            children: [
                              PromptChip(
                                text: 'Explain AI Gateway architecture',
                                onTap: () {
                                  context.read<ChatCubit>().sendMessage(
                                    'Explain AI Gateway architecture',
                                  );
                                },
                              ),
                              PromptChip(
                                text: 'What is this AI Architecture is using?',
                                onTap: () {
                                  context.read<ChatCubit>().sendMessage(
                                    'Im using flutter for frontend, and api gateway for backend is using nextJS.'
                                    'This flutter app is connected to the backend using REST API'
                                    'The gateway handles API key security, prompt construction, error handling, and provider abstraction. This ensures the frontend stays lightweight and secure',
                                  );
                                },
                              ),
                              PromptChip(
                                text: 'Optimize REST API performance',
                                onTap: () {
                                  context.read<ChatCubit>().sendMessage(
                                    'Optimize REST API performance',
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isUser = msg.isUser;

                    return Align(
                      alignment: isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.all(12),
                        constraints: const BoxConstraints(maxWidth: 600),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.blue : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: isUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            isUser
                                ? Text(
                                    msg.text,
                                    style: const TextStyle(color: Colors.white),
                                  )
                                : MarkdownBody(
                                    data: msg.text,
                                    selectable: true,
                                  ),
                            const SizedBox(height: 4),
                            Text(
                              _formatTime(msg.timestamp),
                              style: TextStyle(
                                fontSize: 10,
                                color: isUser ? Colors.white70 : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          /// Error + Retry
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state is ChatError) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.error,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          context.read<ChatCubit>().retry();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),

          /// Loading indicator
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state is ChatLoading) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: CircularProgressIndicator(),
                );
              }
              return const SizedBox.shrink();
            },
          ),

          /// Input box
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  final isLoading = state is ChatLoading;

                  return Row(
                    children: [
                      Expanded(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 150, // Maximum height for input
                          ),
                          child: Scrollbar(
                            child: TextField(
                              controller: _controller,
                              enabled: !isLoading,
                              maxLines: null, // allow multiple lines
                              minLines: 1,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              decoration: InputDecoration(
                                hintText: 'Ask something...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: isLoading
                            ? null
                            : () {
                                final text = _controller.text.trim();
                                if (text.isNotEmpty) {
                                  context.read<ChatCubit>().sendMessage(text);
                                  _controller.clear();
                                }
                              },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
