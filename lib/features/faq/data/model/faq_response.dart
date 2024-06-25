// To parse this JSON data, do
//
//     final activityResponse = activityResponseFromJson(jsonString);

import 'dart:convert';

List<FaqResponse> listFaqResponseFromJson(String str) => List<FaqResponse>.from(
    json.decode(str).map((x) => FaqResponse.fromJson(x)));

FaqResponse faqResponseFromJson(String str) =>
    FaqResponse.fromJson(json.decode(str));

String faqResponseToJson(FaqResponse data) => json.encode(data.toJson());

class FaqResponse {
  String faqQuestion;
  String faqAnswer;
  int eveId;
  bool? faqIsActive;
  int faqId;
  final List<ImageFaq> imageFaqs;

  FaqResponse({
    required this.faqQuestion,
    required this.faqAnswer,
    required this.eveId,
    required this.faqIsActive,
    required this.faqId,
    required this.imageFaqs,
  });

  factory FaqResponse.fromJson(Map<String, dynamic> json) => FaqResponse(
        faqQuestion: json["faq_question"],
        faqAnswer: json["faq_answer"],
        eveId: json["eve_id"],
        faqIsActive: json["faq_is_active"],
        faqId: json["faq_id"],
        imageFaqs: json["imageFaqs"] != null
            ? List<ImageFaq>.from(
                json["imageFaqs"].map((x) => ImageFaq.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "faq_question": faqQuestion,
        "faq_answer": faqAnswer,
        "eve_id": eveId,
        "faq_is_active": faqIsActive,
        "faq_id": faqId,
        "imageFaqs": List<dynamic>.from(imageFaqs.map((x) => x.toJson())),
      };
}

class ImageFaq {
  final int ifqId;
  final String ifqImage;

  ImageFaq({
    required this.ifqId,
    required this.ifqImage,
  });

  factory ImageFaq.fromJson(Map<String, dynamic> json) => ImageFaq(
        ifqId: json["ifq_id"],
        ifqImage: json["ifq_image"],
      );

  Map<String, dynamic> toJson() => {
        "ifq_id": ifqId,
        "ifq_image": ifqImage,
      };
}
