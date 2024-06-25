import 'package:pamphlets_management/features/faq/data/model/faq_response.dart';

final class Faq {
  final int faqId;
  final int eventId;
  String question;
  String answer;
  List<ImageFaq> images;

  Faq({
    required this.faqId,
    required this.question,
    required this.answer,
    required this.eventId,
    required this.images,
  });
}
