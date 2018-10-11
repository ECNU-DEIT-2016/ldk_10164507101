@TestOn('browser')
import 'package:angular_test/angular_test.dart';
import 'package:test/test.dart';
import 'package:first_app/app_component2.dart';
import 'package:first_app/app_component2.template.dart' as ng2;

void main() {
  final testBed =
      NgTestBed.forComponent<AppComponent2>(ng2.AppComponent2NgFactory);
  NgTestFixture<AppComponent2> fixture;

  setUp(() async {
    fixture = await testBed.create();
  });

  tearDown(disposeAnyRunningTest);

  test('heading', () {
    expect(fixture.text, contains('My First AngularDart App'));
  });

  // Testing info: https://webdev.dartlang.org/angular/guide/testing
}
