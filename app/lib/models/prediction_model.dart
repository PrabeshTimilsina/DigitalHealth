class Prediction {
  final int prediction;
  final String result;

  Prediction({required this.prediction, required this.result});

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      prediction: json['prediction'],
      result: json['result'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prediction': prediction,
      'result': result,
    };
  }
}
