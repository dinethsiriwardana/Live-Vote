import 'package:live_vote/data/model/event_model.dart';
import 'package:live_vote/data/model/single_event_model.dart';

abstract class Database {
  Future<void> senddata(EventModel event);
  Future<void> readData();
  Future<Event> checkEvent(String eventId);
}
