class QuickAction {
  final String quickAction;
  final String quickSend;

  QuickAction({required this.quickAction, required this.quickSend});

  Map<String, dynamic> toJson() => {
    'quickAction': quickAction,
    'quickSend': quickSend,
  };

  factory QuickAction.fromJson(Map<String, dynamic> json) {
    return QuickAction(
      quickAction: json['quickAction'],
      quickSend: json['quickSend'],
    );
  }

  QuickAction copyWith({String? quickAction, String? quickSend}) {
    return QuickAction(
      quickAction: quickAction ?? this.quickAction,
      quickSend: quickSend ?? this.quickSend,
    );
  }
}
