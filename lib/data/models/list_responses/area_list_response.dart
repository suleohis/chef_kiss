import '../list_items/area_list_item.dart';

class AreaListResponse {
  List<AreaListItem>? areas; // Renamed to 'areas' for clarity in the model

  AreaListResponse({this.areas});

  factory AreaListResponse.fromJson(Map<String, dynamic> json) {
    return AreaListResponse(
      areas: json['meals'] != null // API uses 'meals' key for area list
          ? (json['meals'] as List)
          .map((i) => AreaListItem.fromJson(i as Map<String, dynamic>))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (areas != null) {
      data['meals'] = areas!.map((v) => v.toJson()).toList(); // Convert back to 'meals' for API
    }
    return data;
  }
}