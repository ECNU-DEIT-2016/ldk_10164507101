import 'package:angular/angular.dart';
// import 'package:sqljocky/sqljocky.dart';
import 'package:first_app/app_component.template.dart' as ng;
//import 'package:first_app/app_component2.template.dart' as ng2;
// import 'package:first_app/my_component.template.dart' as ng;
void main() {
  runApp(ng.AppComponentNgFactory);
  //runApp(ng2.AppComponent2NgFactory);
  // var pool = new ConnectionPool(host: 'localhost',port: 3306, user: 'root', password: 'ShepherdLee0519', db: 'test_mysql', max: 5);
}
