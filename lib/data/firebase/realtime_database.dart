import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:live_vote/data/api/connection.dart';
import 'package:live_vote/data/model/answer_model.dart';
import 'package:live_vote/data/model/event_model.dart';
import 'package:live_vote/data/model/question_model.dart';
import 'package:live_vote/data/model/single_event_model.dart';

class FirestoreDatabase {
  final db = FirebaseFirestore.instance;
  final apipath = ApiPath();

  @override
  Future<void> senddata(EventModel event) async {
    try {} catch (e) {
      if (kDebugMode) {
        print("Error in sending data to firebase");
        print(e);
      }
    }
  }

  Future<void> addEvent(Event event) async {
    try {
      db.collection("events").doc(event.id).set(event.toJson());
    } catch (e) {
      if (kDebugMode) {
        print("Error in sending data to firebase");
        print(e);
      }
    }
  }

  Future<void> addQuestion(String eventId, Question question) async {
    try {
      db
          .collection("events/$eventId/questions")
          .doc(question.id.toString())
          .set(question.toJson());
    } catch (e) {
      if (kDebugMode) {
        print("Error in sending data to firebase");
        print(e);
      }
    }
  }

  Future<void> addAnswer(String eventId, int questionId, Answer answer) async {
    try {
      db
          .collection("events/$eventId/questions/$questionId/answers")
          .doc(answer.id.toString())
          .set(answer.toJson());
    } catch (e) {
      if (kDebugMode) {
        print("Error in sending data to firebase");
        print(e);
      }
    }
  }

  @override
  Future<void> readData() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('users/123');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data.runtimeType);
    });
  }

  Future<List<Answer>> checkEventAnswer(String eventId, int q) async {
    String path = ApiPath.answerPath(eventId, q);
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(path).get();
    List<Answer> answers = querySnapshot.docs.map((doc) {
      return Answer.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
    return answers;
  }

  Future<List<Question>> checkEventQustion(String eventId) async {
    String path = ApiPath.queAllPath(eventId);
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(path).get();
    List<Question> questions =
        await Future.wait(querySnapshot.docs.map((doc) async {
      dynamic data = doc.data();
      List<Answer> ans = await checkEventAnswer(eventId, data['id']);
      return Question.fromJson(doc.data() as Map<String, dynamic>, ans);
    }));

    return questions;
  }

  Future<Event> checkEvent(String eventId) async {
    final reference =
        FirebaseFirestore.instance.collection('events').doc(eventId.toString());
    // print(reference);
    final snapshot = await reference.get();
    List<Question> q = await checkEventQustion(eventId);
    Event event = Event.fromJson(snapshot.data()!, q);
    return event;
  }

  Future<void> updateEvent(String eventId, int que, int anw) async {
    try {
      String path = ApiPath.selectedAnswerPath(eventId, que, anw);
      print(path);
      final docRef =
          FirebaseFirestore.instance.collection(path).doc(anw.toString());
      await docRef.update({'noOfVotes': FieldValue.increment(1)});
    } catch (e) {
      if (kDebugMode) {
        print("Error in sending data to firebase");
        print(e);
      }
    }
  }
}
