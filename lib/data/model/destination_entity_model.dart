// To parse this JSON data, do
//
//     final destinationEntity = destinationEntityFromJson(jsonString);

import 'dart:convert';

DestinationEntity destinationEntityFromJson(String str) =>
    DestinationEntity.fromJson(json.decode(str));

String destinationEntityToJson(DestinationEntity data) =>
    json.encode(data.toJson());

class DestinationEntity {
  String id;
  String title;
  String stemId;
  bool isLeaf;
  int postcoordinationAvailability;
  bool hasCodingNote;
  bool hasMaternalChapterLink;
  bool hasPerinatalChapterLink;
  // List<MatchingPv> matchingPVs;
  bool propertiesTruncated;
  bool isResidualOther;
  bool isResidualUnspecified;
  String chapter;
  dynamic theCode;
  double score;
  bool titleIsASearchResult;
  bool titleIsTopScore;
  int entityType;
  bool important;
  List<dynamic> descendants;

  DestinationEntity({
    required this.id,
    required this.title,
    required this.stemId,
    required this.isLeaf,
    required this.postcoordinationAvailability,
    required this.hasCodingNote,
    required this.hasMaternalChapterLink,
    required this.hasPerinatalChapterLink,
    // required this.matchingPVs,
    required this.propertiesTruncated,
    required this.isResidualOther,
    required this.isResidualUnspecified,
    required this.chapter,
    required this.theCode,
    required this.score,
    required this.titleIsASearchResult,
    required this.titleIsTopScore,
    required this.entityType,
    required this.important,
    required this.descendants,
  });

  DestinationEntity copyWith({
    String? id,
    String? title,
    String? stemId,
    bool? isLeaf,
    int? postcoordinationAvailability,
    bool? hasCodingNote,
    bool? hasMaternalChapterLink,
    bool? hasPerinatalChapterLink,
    // List<MatchingPv>? matchingPVs,
    bool? propertiesTruncated,
    bool? isResidualOther,
    bool? isResidualUnspecified,
    String? chapter,
    dynamic theCode,
    double? score,
    bool? titleIsASearchResult,
    bool? titleIsTopScore,
    int? entityType,
    bool? important,
    List<dynamic>? descendants,
  }) =>
      DestinationEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        stemId: stemId ?? this.stemId,
        isLeaf: isLeaf ?? this.isLeaf,
        postcoordinationAvailability:
            postcoordinationAvailability ?? this.postcoordinationAvailability,
        hasCodingNote: hasCodingNote ?? this.hasCodingNote,
        hasMaternalChapterLink:
            hasMaternalChapterLink ?? this.hasMaternalChapterLink,
        hasPerinatalChapterLink:
            hasPerinatalChapterLink ?? this.hasPerinatalChapterLink,
        // matchingPVs: matchingPVs ?? this.matchingPVs,
        propertiesTruncated: propertiesTruncated ?? this.propertiesTruncated,
        isResidualOther: isResidualOther ?? this.isResidualOther,
        isResidualUnspecified:
            isResidualUnspecified ?? this.isResidualUnspecified,
        chapter: chapter ?? this.chapter,
        theCode: theCode ?? this.theCode,
        score: score ?? this.score,
        titleIsASearchResult: titleIsASearchResult ?? this.titleIsASearchResult,
        titleIsTopScore: titleIsTopScore ?? this.titleIsTopScore,
        entityType: entityType ?? this.entityType,
        important: important ?? this.important,
        descendants: descendants ?? this.descendants,
      );

  factory DestinationEntity.fromJson(Map<String, dynamic> json) =>
      DestinationEntity(
        id: json["id"],
        title: json["title"],
        stemId: json["stemId"],
        isLeaf: json["isLeaf"],
        postcoordinationAvailability: json["postcoordinationAvailability"],
        hasCodingNote: json["hasCodingNote"],
        hasMaternalChapterLink: json["hasMaternalChapterLink"],
        hasPerinatalChapterLink: json["hasPerinatalChapterLink"],
        // matchingPVs: List<MatchingPv>.from(
        // json["matchingPVs"].map((x) => MatchingPv.fromJson(x))),
        propertiesTruncated: json["propertiesTruncated"],
        isResidualOther: json["isResidualOther"],
        isResidualUnspecified: json["isResidualUnspecified"],
        chapter: json["chapter"],
        theCode: json["theCode"],
        score: json["score"]?.toDouble(),
        titleIsASearchResult: json["titleIsASearchResult"],
        titleIsTopScore: json["titleIsTopScore"],
        entityType: json["entityType"],
        important: json["important"],
        descendants: List<dynamic>.from(json["descendants"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "stemId": stemId,
        "isLeaf": isLeaf,
        "postcoordinationAvailability": postcoordinationAvailability,
        "hasCodingNote": hasCodingNote,
        "hasMaternalChapterLink": hasMaternalChapterLink,
        "hasPerinatalChapterLink": hasPerinatalChapterLink,
        // "matchingPVs": List<dynamic>.from(matchingPVs.map((x) => x.toJson())),
        "propertiesTruncated": propertiesTruncated,
        "isResidualOther": isResidualOther,
        "isResidualUnspecified": isResidualUnspecified,
        "chapter": chapter,
        "theCode": theCode,
        "score": score,
        "titleIsASearchResult": titleIsASearchResult,
        "titleIsTopScore": titleIsTopScore,
        "entityType": entityType,
        "important": important,
        "descendants": List<dynamic>.from(descendants.map((x) => x)),
      };
}

// class MatchingPv {
//   String propertyId;
//   String label;
//   double score;
//   bool important;
//   String foundationUri;
//   int propertyValueType;

//   MatchingPv({
//     required this.propertyId,
//     required this.label,
//     required this.score,
//     required this.important,
//     required this.foundationUri,
//     required this.propertyValueType,
//   });

//   MatchingPv copyWith({
//     String? propertyId,
//     String? label,
//     double? score,
//     bool? important,
//     String? foundationUri,
//     int? propertyValueType,
//   }) =>
//       MatchingPv(
//         propertyId: propertyId ?? this.propertyId,
//         label: label ?? this.label,
//         score: score ?? this.score,
//         important: important ?? this.important,
//         foundationUri: foundationUri ?? this.foundationUri,
//         propertyValueType: propertyValueType ?? this.propertyValueType,
//       );

//   factory MatchingPv.fromJson(Map<String, dynamic> json) => MatchingPv(
//         propertyId: json["propertyId"],
//         label: json["label"],
//         score: json["score"]?.toDouble(),
//         important: json["important"],
//         foundationUri: json["foundationUri"],
//         propertyValueType: json["propertyValueType"],
//       );

//   Map<String, dynamic> toJson() => {
//         "propertyId": propertyId,
//         "label": label,
//         "score": score,
//         "important": important,
//         "foundationUri": foundationUri,
//         "propertyValueType": propertyValueType,
//       };
// }
