// To parse this JSON data, do
//
//     final surveyPollModel = surveyPollModelFromJson(jsonString);

import 'dart:convert';

List<SurveyPollModel> surveyPollModelFromJson(String str) => List<SurveyPollModel>.from(json.decode(str).map((x) => SurveyPollModel.fromJson(x)));

String surveyPollModelToJson(List<SurveyPollModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SurveyPollModel {
    SurveyPollModel({
        this.id,
        this.title,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.questions,
    });

    final int? id;
    final String? title;
    final String? description;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final List<Question>? questions;

    factory SurveyPollModel.fromJson(Map<String, dynamic> json) => SurveyPollModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
    };
}

class Question {
    Question({
        this.id,
        this.surveyId,
        this.question,
        this.description,
        this.answerType,
        this.options,
        this.createdAt,
        this.updatedAt,
    });

    final int? id;
    final int? surveyId;
    final String? question;
    final String? description;
    final String? answerType;
    final List<String>? options;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        surveyId: json["survey_id"],
        question: json["question"],
        description: json["description"],
        answerType: json["answer_type"],
        options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "survey_id": surveyId,
        "question": question,
        "description": description,
        "answer_type": answerType,
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}



//FOR POST DATA
SurveyPollPostModel surveyPollPostModelFromJson(String str) => SurveyPollPostModel.fromJson(json.decode(str));

String surveyPollPostModelToJson(SurveyPollPostModel data) => json.encode(data.toJson());

class SurveyPollPostModel {
    SurveyPollPostModel({
        this.answers,
        required this.id
    });

    final List<Answer>? answers;
    final String id;

    factory SurveyPollPostModel.fromJson(Map<String, dynamic> json) => SurveyPollPostModel(
      id: json["id"],
        answers: json["answers"] == null ? [] : List<Answer>.from(json["answers"]!.map((x) => Answer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "answers": answers == null ? [] : List<dynamic>.from(answers!.map((x) => x.toJson())),
    };
}

class Answer {
    Answer({
        this.questionId,
        this.answer,
    });

     int? questionId;
      String? answer;

    factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        questionId: json["question_id"],
        answer: json["answer"],
    );

    Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "answer": answer,
    };
}
