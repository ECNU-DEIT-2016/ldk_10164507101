@TestOn('browser')
import 'package:angular_test/angular_test.dart';
import 'package:test/test.dart';
import 'package:first_app/my_component.dart';
import 'package:first_app/my_component.template.dart' as ng;

void main() {
  final testBed =
      NgTestBed.forComponent<MyComponent>(ng.MyComponentNgFactory);
  NgTestFixture<MyComponent> fixture;

  setUp(() async {
    fixture = await testBed.create();
  });

  tearDown(disposeAnyRunningTest);

  test('heading', () {
    expect(fixture.text, contains('My First AngularDart App'));
  });

  // Testing info: https://webdev.dartlang.org/angular/guide/testing
}
