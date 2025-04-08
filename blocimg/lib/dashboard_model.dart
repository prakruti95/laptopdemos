class DashboardItem {
  final String id;
  final String name;
  final String url;

  DashboardItem({required this.id, required this.name, required this.url});

  factory DashboardItem.fromJson(Map<String, dynamic> json) {
    return DashboardItem(
      id: json['id'],
      name: json['name'],
      url: json['url'],
    );
  }
}
