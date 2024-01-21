import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../votingpoll.dart';


class VotingPollProvider with ChangeNotifier {
  final CollectionReference _pollsCollection =
  FirebaseFirestore.instance.collection('polls');
  List<VotingPoll> _polls = [];

  List<VotingPoll> get polls => _polls;

  void fetchPolls() {
    _pollsCollection.snapshots().listen((snapshot) {
      _polls = snapshot.docs
          .map((doc) => VotingPoll(
        id: doc.id,
        question: doc['question'],
        options: Map<String, int>.from(doc['options']),
      ))
          .toList();
      notifyListeners();
    });
  }

  Future<void> vote(String pollId, String option) async {
    final DocumentReference pollRef = _pollsCollection.doc(pollId);

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final DocumentSnapshot pollSnapshot = await transaction.get(pollRef);
        final Map<String, int> options =
        Map<String, int>.from(pollSnapshot['options']);
        options.update(option, (value) => value + 1);

        transaction.update(pollRef, {'options': options});
      });
    } catch (e) {
      print('Voting failed: $e');
    }
  }
}