import 'package:emirgpt/core/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

import '../blocs/export_blocs.dart';
import 'widgets/promptChip.dart';
import 'widgets/thinking_indicator.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            context.go('/');
          },
          child: const Text('BookingGPT'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              context.read<BookingCubit>().clearHistory();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<BookingCubit, BookingChatState>(
              builder: (context, state) {
                final messages = state.messages;

                if (messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'BookingGPT',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Ask for venue availability, price, and schedule',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                        const SizedBox(height: 32),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          alignment: WrapAlignment.center,
                          children: [
                            PromptChip(
                              text:
                                  'Book me badminton courts for tommorrow 5pm',
                              onTap: () {
                                context.read<BookingCubit>().sendMessage(
                                  'Book me badminton courts for tommorrow 5pm',
                                );
                              },
                            ),
                            PromptChip(
                              text:
                                  'How is my data Process for using this app ?',
                              onTap: () {
                                context.read<BookingCubit>().sendMessage(
                                  'How is my data Process for using this app ?',
                                );
                              },
                            ),
                            PromptChip(
                              text: 'Book me a tennis court in next hour',
                              onTap: () {
                                context.read<BookingCubit>().sendMessage(
                                  'Book me a tennis court in next hour',
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }

                return BlocListener<BookingCubit, BookingChatState>(
                  listener: (context, state) {
                    if (_scrollController.hasClients) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      });
                    }
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      final isUser = msg.isUser;
                      final isThinking = msg.isThinking;

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
                                  ? SelectableText(
                                      msg.text,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  : isThinking
                                  ? thinkingIndicator()
                                  : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.copy,
                                            size: 16,
                                          ),
                                          onPressed: () {
                                            Clipboard.setData(
                                              ClipboardData(text: msg.text),
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: MarkdownBody(
                                            onTapLink: (text, href, title) =>
                                                Helpers.openLink(href),
                                            data: msg.text,
                                            selectable: true,
                                            styleSheet: MarkdownStyleSheet(
                                              p: const TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              const SizedBox(height: 4),
                              isThinking
                                  ? const SizedBox.shrink()
                                  : Text(
                                      Helpers.formatTime(msg.timestamp),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: isUser
                                            ? Colors.white70
                                            : Colors.black54,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          BlocBuilder<BookingCubit, BookingChatState>(
            builder: (context, state) {
              if (state is BookingError) {
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
                          context.read<BookingCubit>().retry();
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

          BlocBuilder<BookingCubit, BookingChatState>(
            builder: (context, state) {
              if (state is BookingLoading) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: CircularProgressIndicator(),
                );
              }
              return const SizedBox.shrink();
            },
          ),

          BlocBuilder<BookingCubit, BookingChatState>(
            builder: (context, state) {
              final isEmpty = state.messages.isEmpty;

              if (isEmpty) {
                return Expanded(
                  child: Center(
                    child: SizedBox(width: 800, child: _buildInputBar(context)),
                  ),
                );
              }

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: _buildInputBar(context),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar(BuildContext context) {
    final isLoading = context.watch<BookingCubit>().state is BookingLoading;

    return Row(
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 40, maxHeight: 150),
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (event) {
                if (event is RawKeyDownEvent &&
                    event.logicalKey == LogicalKeyboardKey.enter &&
                    !event.isShiftPressed) {
                  final text = _controller.text.trim();
                  if (text.isNotEmpty) {
                    context.read<BookingCubit>().sendMessage(text);
                    Future.delayed(Duration.zero, () => _controller.clear());
                  }
                }
              },
              child: TextField(
                controller: _controller,
                enabled: !isLoading,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Ask about venue booking...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
                    context.read<BookingCubit>().sendMessage(text);
                    _controller.clear();
                  }
                },
        ),
      ],
    );
  }
}
