import 'package:live_vote/data/model/single_event_model.dart';

class EventModel {
  List<Event> event;

  EventModel({required this.event});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      event: List<Event>.from(
          json['event'].map((event) => Event.fromJson(event, []))),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'event': event.map((event) => event.toJson()).toList(),
    };
  }
}
