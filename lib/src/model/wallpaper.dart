class Wallpaper {
  Wallpaper({
    required this.id,
    required this.url,
    required this.photographer,
    required this.mediumImage,
    required this.originalImage,
    required this.alt,
  });

  final int id;
  final String url;
  final String photographer;
  final String mediumImage;
  final String originalImage;
  final String alt;

  factory Wallpaper.fromRemoteMap(Map<String, dynamic> json) => Wallpaper(
        id: json["id"],
        url: json["url"],
        photographer: json["photographer"],
        mediumImage: json["src"]["medium"],
        originalImage: json["src"]["original"],
        alt: json["alt"],
      );

  factory Wallpaper.fromLocalMap(Map<String, dynamic> json) => Wallpaper(
    id: json["id"],
    url: json["url"],
    photographer: json["photographer"],
    mediumImage: json["mediumImage"],
    originalImage: json["originalImage"],
    alt: json["alt"],
  );

  Map<String, dynamic> toMap() => {
        "id": id,
        "url": url,
        "photographer": photographer,
        "mediumImage": mediumImage,
        "originalImage": originalImage,
        "alt": alt,
      };
}
