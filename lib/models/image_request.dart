class ImageRequest {
  String imageBase64;

  ImageRequest({required this.imageBase64});

  factory ImageRequest.fromJson(Map<String, dynamic> json) => ImageRequest(
        imageBase64: json['image_base64'],
      );

  Map<String, dynamic> toJson() => {
        'image_base64': imageBase64,
      };
}
