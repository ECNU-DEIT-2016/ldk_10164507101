import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'todo_list_service2.dart';

@Component(
  selector: 'todo-list2',
  styleUrls: ['todo_list_component2.css'],
  templateUrl: 'todo_list_component2.html',
  directives: [
    MaterialCheckboxComponent,
    MaterialFabComponent,
    MaterialIconComponent,
    materialInputDirectives,
    NgFor,
    NgIf,
  ],
  providers: [const ClassProvider(TodoListService2)],
)
class TodoListComponent2 implements OnInit {
  final TodoListService2 todoListService;

  List<String> items = [];
  String newTodo = '';

  TodoListComponent2(this.todoListService);

  @override
  Future<Null> ngOnInit() async {
    items = await todoListService.getTodoList();
  }

  void add() {
    items.add(newTodo);
    newTodo = '';
  }

  String remove(int index) => items.removeAt(index);
}
