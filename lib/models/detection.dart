class DetectionResponse {
  List<Detection> detections;
  String processedImageBase64;

  DetectionResponse({
    required this.detections,
    required this.processedImageBase64,
  });

  factory DetectionResponse.fromJson(Map<String, dynamic> json) =>
      DetectionResponse(
        detections: (json['detections'] as List)
            .map((x) => Detection.fromJson(x))
            .toList(),
        processedImageBase64: json['processed_image_base64'],
      );

  Map<String, dynamic> toJson() => {
        'detections': List<dynamic>.from(detections.map((x) => x.toJson())),
        'processed_image_base64': processedImageBase64,
      };
}

class Detection {
  String label;
  double confidence;
  Fault faultDetails;

  Detection({
    required this.label,
    required this.confidence,
    required this.faultDetails,
  });

  factory Detection.fromJson(Map<String, dynamic> json) => Detection(
        label: json['label'],
        confidence: json['confidence'],
        faultDetails: Fault.fromJson(json['fault_details']),
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'confidence': confidence,
        'fault_details': faultDetails.toJson(),
      };
}

class Fault {
  int id;
  String label;
  String fault;
  String causes;
  String solution;

  Fault({
    required this.id,
    required this.label,
    required this.fault,
    required this.causes,
    required this.solution,
  });

  factory Fault.fromJson(Map<String, dynamic> json) => Fault(
        id: json['id'],
        label: json['label'],
        fault: json['fault'],
        causes: json['causes'],
        solution: json['solution'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'fault': fault,
        'causes': causes,
        'solution': solution,
      };
}
