import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:votingapp/providers/poll_providers.dart';
import 'package:votingapp/screens/homescreen.dart';
import 'votingpoll.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final votingPollProvider = Provider.of<VotingPollProvider>(context);
    votingPollProvider.fetchPolls();

    return MaterialApp(
      title: 'Voting Poll',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PollListScreen(),
    );
  }
}

