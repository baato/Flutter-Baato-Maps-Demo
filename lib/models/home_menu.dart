class HomeMenu {
  String? title, subTitle;
  int? icon;

  HomeMenu({this.title, this.subTitle});

  HomeMenu.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['subTitle'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subTitle'] = subTitle;
    data['icon'] = icon;
    return data;
  }
}
