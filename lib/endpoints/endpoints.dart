class Endpoints {
  static const String host = "192.168.88.120";
  // static const String urlUAS = ' http://192.168.184.120:5000';

  static const String baseUAS = "http://$host:5000";

  // Menu
  static const String menuRead = "$baseUAS/api/v1/menu/read";
  static const String menuCreate = "$baseUAS/api/v1/menu/create";
  static const String menuDelete = "$baseUAS/api/v1/menu/delete";
  static const String menuUpdate = "$baseUAS/api/v1/menu/update";

  //auth
  static const String login = "$baseUAS/api/v1/auth/login";
}
