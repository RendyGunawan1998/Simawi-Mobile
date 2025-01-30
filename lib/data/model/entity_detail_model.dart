// To parse this JSON data, do
//
//     final entityDetail = entityDetailFromJson(jsonString);

import 'dart:convert';

EntityDetail entityDetailFromJson(String str) =>
    EntityDetail.fromJson(json.decode(str));

String entityDetailToJson(EntityDetail data) => json.encode(data.toJson());

class EntityDetail {
  String context;
  String id;
  List<String> parent;
  List<String> child;
  String browserUrl;
  List<String> ancestor;
  Definition title;
  List<Inclusion> synonym;
  Definition definition;
  List<Inclusion> inclusion;
  List<String> relatedEntitiesInPerinatalChapter;

  EntityDetail({
    required this.context,
    required this.id,
    required this.parent,
    required this.child,
    required this.browserUrl,
    required this.ancestor,
    required this.title,
    required this.synonym,
    required this.definition,
    required this.inclusion,
    required this.relatedEntitiesInPerinatalChapter,
  });

  EntityDetail copyWith({
    String? context,
    String? id,
    List<String>? parent,
    List<String>? child,
    String? browserUrl,
    List<String>? ancestor,
    Definition? title,
    List<Inclusion>? synonym,
    Definition? definition,
    List<Inclusion>? inclusion,
    List<String>? relatedEntitiesInPerinatalChapter,
  }) =>
      EntityDetail(
        context: context ?? this.context,
        id: id ?? this.id,
        parent: parent ?? this.parent,
        child: child ?? this.child,
        browserUrl: browserUrl ?? this.browserUrl,
        ancestor: ancestor ?? this.ancestor,
        title: title ?? this.title,
        synonym: synonym ?? this.synonym,
        definition: definition ?? this.definition,
        inclusion: inclusion ?? this.inclusion,
        relatedEntitiesInPerinatalChapter: relatedEntitiesInPerinatalChapter ??
            this.relatedEntitiesInPerinatalChapter,
      );

  factory EntityDetail.fromJson(Map<String, dynamic> json) => EntityDetail(
        context: json["@context"],
        id: json["@id"],
        parent: List<String>.from(json["parent"].map((x) => x)),
        child: List<String>.from(json["child"].map((x) => x)),
        browserUrl: json["browserUrl"],
        ancestor: List<String>.from(json["ancestor"].map((x) => x)),
        title: Definition.fromJson(json["title"]),
        synonym: List<Inclusion>.from(
            json["synonym"].map((x) => Inclusion.fromJson(x))),
        definition: Definition.fromJson(json["definition"]),
        inclusion: List<Inclusion>.from(
            json["inclusion"].map((x) => Inclusion.fromJson(x))),
        relatedEntitiesInPerinatalChapter: List<String>.from(
            json["relatedEntitiesInPerinatalChapter"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "@context": context,
        "@id": id,
        "parent": List<dynamic>.from(parent.map((x) => x)),
        "child": List<dynamic>.from(child.map((x) => x)),
        "browserUrl": browserUrl,
        "ancestor": List<dynamic>.from(ancestor.map((x) => x)),
        "title": title.toJson(),
        "synonym": List<dynamic>.from(synonym.map((x) => x.toJson())),
        "definition": definition.toJson(),
        "inclusion": List<dynamic>.from(inclusion.map((x) => x.toJson())),
        "relatedEntitiesInPerinatalChapter":
            List<dynamic>.from(relatedEntitiesInPerinatalChapter.map((x) => x)),
      };
}

class Definition {
  String language;
  String value;

  Definition({
    required this.language,
    required this.value,
  });

  Definition copyWith({
    String? language,
    String? value,
  }) =>
      Definition(
        language: language ?? this.language,
        value: value ?? this.value,
      );

  factory Definition.fromJson(Map<String, dynamic> json) => Definition(
        language: json["@language"],
        value: json["@value"],
      );

  Map<String, dynamic> toJson() => {
        "@language": language,
        "@value": value,
      };
}

class Inclusion {
  Definition label;

  Inclusion({
    required this.label,
  });

  Inclusion copyWith({
    Definition? label,
  }) =>
      Inclusion(
        label: label ?? this.label,
      );

  factory Inclusion.fromJson(Map<String, dynamic> json) => Inclusion(
        label: Definition.fromJson(json["label"]),
      );

  Map<String, dynamic> toJson() => {
        "label": label.toJson(),
      };
}
