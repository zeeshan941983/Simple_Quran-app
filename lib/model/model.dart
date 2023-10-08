class Result {
  String? id;
  String? sura;
  String? aya;
  String? arabicText;
  String? translation;
  String? footnotes;

  Result({
    this.id,
    this.sura,
    this.aya,
    this.arabicText,
    this.translation,
    this.footnotes,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'],
      sura: json['sura'],
      aya: json['aya'],
      arabicText: json['arabic_text'],
      translation: json['translation'],
      footnotes: json['footnotes'],
    );
  }
}
