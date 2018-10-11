import 'package:angular/angular.dart';

import 'src/todo_list2/todo_list_component2.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app2',
  styleUrls: ['app_component2.css'],
  templateUrl: 'app_component2.html',
  directives: [TodoListComponent2],
)

class AppComponent2 {
  // Nothing here yet. All logic is in TodoListComponent.
}
