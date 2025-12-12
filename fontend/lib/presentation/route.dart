import 'package:fontend/presentation/screens/home-screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class MainRouteNames{
  static const home = "/home";
  static const splash = "/";
}
class Page{
  String name;
  Page(this.name);
}
class MainRoutePages{
  static final pages = [
    GetPage(
      name: MainRouteNames.home,
      page: () => HomePage(),
    ),

  ];

}