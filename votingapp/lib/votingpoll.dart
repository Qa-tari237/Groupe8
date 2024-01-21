import 'package:flutter/foundation.dart';

class VotingPoll {
  final String id;
  final String question;
  final Map<String, int> options;

  VotingPoll({
    required this.id,
    required this.question,
    required this.options,
  });
}