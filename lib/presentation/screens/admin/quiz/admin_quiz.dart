import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:live_vote/Data/firebase/realtime_database.dart';
import 'package:live_vote/const.dart';
import 'package:live_vote/data/model/answer_model.dart';
import 'package:live_vote/data/model/question_model.dart';
import 'package:live_vote/data/model/single_event_model.dart';
import 'package:live_vote/presentation/widget/background.dart';
import 'package:live_vote/presentation/widget/bar_chart_sample.dart';
import 'package:live_vote/presentation/widget/cutom_button.dart';
import 'package:live_vote/presentation/widget/glass_container.dart';
import 'package:live_vote/presentation/widget/responsize_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AdminQuizPage extends StatefulWidget {
  final Event event;
  const AdminQuizPage({super.key, required this.event});

  @override
  State<AdminQuizPage> createState() => _AdminQuizPageState();
}

final StreamController<int> _numberStreamController =
    StreamController<int>.broadcast();

int _currentNumber = 0;
int _currentQ = 0;
int questions = 0;

class _AdminQuizPageState extends State<AdminQuizPage> {
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
                            if (data['liveq'] == -1) {
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  CircularProgressIndicator(
                                    color: CustomeColor().primaryColor,
                                  ),
                                  const SizedBox(
                                    height: 80,
                                  ),
                                  CustomButton(
                                      size: 30.w,
                                      onPressed: () async {
                                        {
                                          await FirestoreDatabase()
                                              .updateLiveQuiz(event.id, 1);
                                        }
                                      },
                                      text: "Start")
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 40.w,
                                                height: 38.h,
                                                child: ListView.builder(
                                                  itemCount: event
                                                      .questions![data['liveq']]
                                                      .answers!
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    int ans = index + 1;
                                                    return SizedBox(
                                                      height: 8.h,
                                                      child: ListTile(
                                                        title: RepText(
                                                          text:
                                                              'Answer $ans ${event.questions![(data['liveq'])].answers![index].answer}',
                                                          size: 20,
                                                          isCenter: false,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              StreamBuilder(
                                                  stream: FirestoreDatabase()
                                                      .checkEventAnswerStream(
                                                          event.id,
                                                          data['liveq']),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          'Something went wrong');
                                                    }
                                                    if (snapshot.hasData) {
                                                      final data =
                                                          (snapshot.data
                                                              as List<Answer>);

                                                      return SizedBox(
                                                        height: 30.h,
                                                        width: 40.w,
                                                        child: CustimBarChart(
                                                          event: data,
                                                        ),
                                                      );
                                                    }
                                                    return CircularProgressIndicator(
                                                      color: CustomeColor()
                                                          .primaryColor,
                                                    );
                                                  }),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomButton(
                                                size: 30.w,
                                                onPressed: () async {
                                                  print(
                                                      "$questions ${event.questions![data['liveq']].answers!.length}");
                                                  if (questions >
                                                      event
                                                          .questions![
                                                              data['liveq']]
                                                          .answers!
                                                          .length) {
                                                    _currentQ--;

                                                    await FirestoreDatabase()
                                                        .updateLiveQuiz(
                                                            event.id, -1);
                                                  }
                                                },
                                                text: '<',
                                              ),
                                              CustomButton(
                                                size: 30.w,
                                                onPressed: () async {
                                                  print(
                                                      "$questions ${event.questions![data['liveq']].answers!.length}");

                                                  if (questions <
                                                      event
                                                          .questions![
                                                              data['liveq']]
                                                          .answers!
                                                          .length) {
                                                    _currentQ++;

                                                    await FirestoreDatabase()
                                                        .updateLiveQuiz(
                                                            event.id, 1);
                                                  }
                                                },
                                                text: '>',
                                              ),
                                            ],
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
