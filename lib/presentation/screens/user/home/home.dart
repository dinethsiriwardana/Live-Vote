import 'package:flutter/material.dart';
import 'package:live_vote/data/firebase/realtime_database.dart';
import 'package:live_vote/data/model/single_event_model.dart';
import 'package:live_vote/presentation/screens/user/quiz/quiz.dart';
import 'package:live_vote/presentation/widget/background.dart';
import 'package:live_vote/presentation/widget/cutom_button.dart';
import 'package:live_vote/presentation/widget/glass_container.dart';
import 'package:live_vote/presentation/widget/responsize_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

TextEditingController _codeController = TextEditingController();
FocusNode _codeFocusNode = FocusNode();

Future<void> _checkCode(BuildContext context) async {
  try {
    FirestoreDatabase database = FirestoreDatabase();
    Event event = await database.checkEvent("dart_event");
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizPage(event: event),
      ),
    );
  } catch (e) {
    print(e.toString());
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    _checkCode(context);
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
                height: 50.h,
                width: 35.w,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RepText(
                        text: "Enter\nthe Code",
                        size: 50,
                      ),
                      SizedBox(
                        width: 80.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 80.w,
                              child: TextField(
                                controller: _codeController,
                                focusNode: _codeFocusNode,
                                decoration: const InputDecoration(
                                  // hintText: "Enter your email address",

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                    borderSide: BorderSide(
                                        color: Colors.white), //<-- SEE HERE
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                    borderSide: BorderSide(
                                        color: Colors.white), //<-- SEE HERE
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomButton(
                        onPressed: () {
                          _checkCode(context);
                        },
                        text: 'Go',
                      )
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
