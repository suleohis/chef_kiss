class CategoryListItem {
  String? strCategory;

  CategoryListItem({this.strCategory});

  factory CategoryListItem.fromJson(Map<String, dynamic> json) {
    return CategoryListItem(
      strCategory: json['strCategory'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strCategory'] = strCategory;
    return data;
  }
}