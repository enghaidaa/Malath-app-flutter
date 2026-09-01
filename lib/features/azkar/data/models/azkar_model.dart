import 'azkar_item_model.dart';

class AzkarModel {
  final int id;
  final String category;
  final String slug;
  final String icon;
  final List<AzkarItemModel> items;

  const AzkarModel({
    required this.id,
    required this.category,
    required this.slug,
    required this.icon,
    this.items = const [],
  });

  factory AzkarModel.fromJson(Map<String, dynamic> json) {
    return AzkarModel(
      id: json['id'] ?? 0,
      category: json['category'] ?? '',
      slug: json['slug'] ?? '',
      icon: json['icon'] ?? '',
      items: json['items'] != null
          ? (json['items'] as List)
              .map(
                (item) => AzkarItemModel.fromJson(
                  item as Map<String, dynamic>,
                ),
              )
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'slug': slug,
      'icon': icon,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
