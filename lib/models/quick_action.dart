class QuickAction {
  final List<String>? quickAction;
  final List<String>? quickSend;

  QuickAction({required this.quickAction, required this.quickSend});

  Map<String, dynamic> toJson() => {
    'quickAction': quickAction,
    'quickSend': quickSend,
  };

  factory QuickAction.fromJson(Map<String, dynamic> json) {
    return QuickAction(
      quickAction: json['quickAction'] as List<String>?,
      quickSend: json['quickSend'] as List<String>?,
    );
  }

  QuickAction copyWith({List<String>? quickAction, List<String>? quickSend}) {
    return QuickAction(
      quickAction: quickAction ?? this.quickAction,
      quickSend: quickSend ?? this.quickSend,
    );
  }
}
