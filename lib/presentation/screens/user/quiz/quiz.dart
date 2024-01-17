import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:live_vote/Data/firebase/realtime_database.dart';
import 'package:live_vote/const.dart';
import 'package:live_vote/data/model/single_event_model.dart';
import 'package:live_vote/presentation/widget/background.dart';
import 'package:live_vote/presentation/widget/cutom_button.dart';
import 'package:live_vote/presentation/widget/glass_container.dart';
import 'package:live_vote/presentation/widget/responsize_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class QuizPage extends StatefulWidget {
  final Event event;
  const QuizPage({super.key, required this.event});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

final StreamController<int> _numberStreamController =
    StreamController<int>.broadcast();

int _currentNumber = 0;

class _QuizPageState extends State<QuizPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Event get event => widget.event;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _numberStreamController.add(1);

    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: backgroundImage,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: CustomeGlassContainer(
                height: 70.h,
                width: 85.w,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StreamBuilder(
                        stream: _firestore
                            .collection('events')
                            .doc(event.id)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.hasData) {
                            final data = snapshot.data as DocumentSnapshot;

                            final questions = data['liveq'];
                            if (data['liveq'] == 0) {
                              return Column(
                                children: [
                                  CircularProgressIndicator(
                                    color: CustomeColor().primaryColor,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  RepText(
                                    text: "Wait...",
                                    size: 20,
                                  ),
                                ],
                              );
                              // Loading indicator while data is fetching.
                            } else {
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      RepText(
                                        text: event.id,
                                        size: 20,
                                      ),
                                      RepText(
                                        text: event.name,
                                        size: 30,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      RepText(
                                        text: event
                                            .questions![questions].question,
                                        size: 40,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  StreamBuilder<int>(
                                    stream: _numberStreamController.stream,
                                    builder: (context, snapshot) {
                                      _currentNumber = snapshot.data ?? 0;

                                      if (snapshot.data == 5) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            RepText(
                                              text:
                                                  'Thank You\n wait for next question',
                                              size: 40,
                                            ),
                                          ],
                                        );
                                      }
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 38.h,
                                            child: ListView.builder(
                                              itemCount: event
                                                  .questions![data['liveq']]
                                                  .answers!
                                                  .length,
                                              itemBuilder: (context, index) {
                                                int ans = index + 1;

                                                return SizedBox(
                                                  height: 8.h,
                                                  child: ListTile(
                                                    title: InkWell(
                                                      onTap: () async {
                                                        try {
                                                          _numberStreamController
                                                              .add(index);
                                                        } catch (e) {}
                                                      },
                                                      child: RepText(
                                                        text:
                                                            'Answer $ans ${event.questions![data['liveq']].answers![index].answer}',
                                                        size: 40,
                                                        isCenter: false,
                                                        color: snapshot.data ==
                                                                index
                                                            ? Colors.green
                                                            : Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          CustomButton(
                                            onPressed: () async {
                                              print(_currentNumber + 1);
                                              await FirestoreDatabase()
                                                  .updateEvent(
                                                      event.id,
                                                      event
                                                          .questions![
                                                              data['liveq']]
                                                          .id,
                                                      _currentNumber + 1);
                                              _numberStreamController.add(5);
                                            },
                                            text: 'Go',
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              );
                            }
                          }
                          return CircularProgressIndicator(
                            color: CustomeColor().primaryColor,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ), /* add child content here */
      ),
    );
  }
}
