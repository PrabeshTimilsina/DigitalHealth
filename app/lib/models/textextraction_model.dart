import 'dart:developer';

class MedicalReport {
  String reportParagraph;
  SummarizeText summarizeText;

  MedicalReport({required this.reportParagraph, required this.summarizeText});

  factory MedicalReport.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return MedicalReport(
      reportParagraph: json['Report Pargraph'],
      summarizeText: SummarizeText.fromJson(json['Summarize_text']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Report Pargraph': reportParagraph,
      'Summarize_text': summarizeText.toJson(),
    };
  }
}

class SummarizeText {
  String findings;
  String summary;

  SummarizeText({required this.findings, required this.summary});

  factory SummarizeText.fromJson(Map<String, dynamic> json) {
    return SummarizeText(
      findings: json['findings'],
      summary: json['summary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'findings': findings,
      'summary': summary,
    };
  }
}
