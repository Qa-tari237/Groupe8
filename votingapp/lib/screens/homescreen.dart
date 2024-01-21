import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/poll_providers.dart';
import '../votingpoll.dart';

class PollListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final votingPollProvider = Provider.of<VotingPollProvider>(context);
    final polls = votingPollProvider.polls;

    return Scaffold(
      appBar: AppBar(
        title: Text('Voting Poll'),
      ),
      body: ListView.builder(
        itemCount: polls.length,
        itemBuilder: (context, index) {
          final poll = polls[index];

          return ListTile(
            title: Text(poll.question),
            subtitle: Text('Poll ID: ${poll.id}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PollDetailsScreen(poll: poll),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PollDetailsScreen extends StatelessWidget {
  final VotingPoll poll;

  const PollDetailsScreen({required this.poll});

  @override
  Widget build(BuildContext context) {
    // Use the poll object in your screen
    return Scaffold(
      appBar: AppBar(
        title: Text('Poll Details'),
      ),
      body: Center(
        child: Text(poll.question),
      ),
    );
  }
}