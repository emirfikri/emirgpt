import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/export_blocs.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ResumeMatcherPage extends StatefulWidget {
  const ResumeMatcherPage({super.key});

  @override
  State<ResumeMatcherPage> createState() => _ResumeMatcherPageState();
}

class _ResumeMatcherPageState extends State<ResumeMatcherPage> {
  final resumeController = TextEditingController();
  final jdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            context.go('/');
          },
          child: const Text('Resume / JD Matcher'),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: resumeController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Resume',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: jdController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Job Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<ResumeMatcherCubit, ResumeMatcherState>(
                  builder: (context, state) {
                    final isLoading = state is ResumeMatcherLoading;

                    return ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              context.read<ResumeMatcherCubit>().matchResume(
                                resume: resumeController.text,
                                jobDescription: jdController.text,
                              );
                            },
                      child: Text('Analyze Fit'),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<ResumeMatcherCubit, ResumeMatcherState>(
                    builder: (context, state) {
                      if (state is ResumeMatcherSuccess) {
                        // return SingleChildScrollView(
                        //   child: SelectableText(state.result),
                        // );
                        // Parse JSON string to Map
                        final jsonData = state.result is String
                            ? jsonDecode(state.result)
                            : state.result;

                        return SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   'Match Score: ${jsonData['matchScore']}%',
                                //   style: const TextStyle(
                                //     fontSize: 18,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                Center(
                                  child: CircularPercentIndicator(
                                    radius: 80.0,
                                    lineWidth: 12.0,
                                    percent:
                                        (jsonData['matchScore'] as num) / 100,
                                    center: SelectableText(
                                      "${jsonData['matchScore']}%",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    progressColor:
                                        (jsonData['matchScore'] as num) >= 70
                                        ? Colors.green
                                        : (jsonData['matchScore'] as num) >= 50
                                        ? Colors.orange
                                        : Colors.red,
                                    backgroundColor: Colors.grey[300]!,
                                    circularStrokeCap: CircularStrokeCap.round,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const SizedBox(height: 12),
                                if (jsonData['matchedSkills'] != null) ...[
                                  const SelectableText(
                                    'Matched Skills:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  ...List<Widget>.from(
                                    (jsonData['matchedSkills'] as List).map(
                                      (e) => SelectableText('• $e'),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                ],
                                if (jsonData['missingSkills'] != null) ...[
                                  const SelectableText(
                                    'Missing Skills:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  ...List<Widget>.from(
                                    (jsonData['missingSkills'] as List).map(
                                      (e) => SelectableText('• $e'),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                ],
                                if (jsonData['improvementSuggestions'] !=
                                    null) ...[
                                  const SelectableText(
                                    'Improvement Suggestions:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  ...List<Widget>.from(
                                    (jsonData['improvementSuggestions'] as List)
                                        .map((e) => SelectableText('• $e')),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      }

                      if (state is ResumeMatcherError) {
                        return SelectableText(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        );
                      }

                      return const Center(
                        child: SelectableText(
                          'Paste resume and Job Title & description to begin',
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Loading overlay
          BlocBuilder<ResumeMatcherCubit, ResumeMatcherState>(
            builder: (context, state) {
              if (state is ResumeMatcherLoading) {
                return Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
