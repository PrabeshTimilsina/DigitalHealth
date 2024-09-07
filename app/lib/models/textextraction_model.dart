class TextExtraction {
  final String reportParagraph;
  final String summarizeText;

  TextExtraction({required this.reportParagraph, required this.summarizeText});

  factory TextExtraction.fromJson(Map<String, dynamic> json) {
    return TextExtraction(
      reportParagraph: json['Report Pargraph'],
      summarizeText: json['Summarize_text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Report Pargraph': reportParagraph,
      'Summarize_text': summarizeText,
    };
  }
}
