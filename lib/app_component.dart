import 'package:angular/angular.dart';

// import 'src/todo_list/todo_list_component.dart';
import 'src/take_attendance/take_attendance_component.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-tag',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  //directives: [TodoListComponent],
  directives:[TakeAttendanceComponent],
)

class AppComponent {
  // Nothing here yet. All logic is in TodoListComponent.
}
