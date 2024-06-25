import 'package:pamphlets_management/features/activities/domain/entities/speakers.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';

final class Activity {
  final int activityId;
  final String name;
  final String? description;
  final String? location;
  final String? urlForm;
  final bool actAsk;
  final DateTime start;
  final DateTime end;
  final Iterable<Speaker>? speakers;
  final Category? category;

  Activity(
      {required this.activityId,
      required this.name,
      this.description,
      this.location,
      this.urlForm,
      required this.actAsk,
      required this.start,
      required this.end,
      this.speakers,
      this.category});
}
