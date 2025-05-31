class AreaListItem {
  String? strArea;

  AreaListItem({this.strArea});

  factory AreaListItem.fromJson(Map<String, dynamic> json) {
    return AreaListItem(
      strArea: json['strArea'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strArea'] = strArea;
    return data;
  }
}