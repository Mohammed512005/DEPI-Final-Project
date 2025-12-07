class ProfileSectionModel {
  String headTitle;
  String subTitle;
  String icon;
  String? routeName;  

  ProfileSectionModel({
    required this.headTitle,
    required this.subTitle,
    required this.icon,
    this.routeName,
  });
}

