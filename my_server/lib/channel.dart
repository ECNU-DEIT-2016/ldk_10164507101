import 'my_server.dart';
import 'dart:math';
/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class MyServerChannel extends ApplicationChannel {
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/
    router
      .route("/users/[:id]").link(()=>MyController());
      ;

    return router;
  }
}
class MyController extends ResourceController {
  // final List<String> things = ['thing1', 'thing2', 'things3', 'things4', 'things5'];
  List<int> items = [];
  int lower_bound = 10164507101;
  int upper_bound = 10164507150;

  MyController(){
    getRandom(10);
  }

  @Operation.get()
  Future<Response> getThings() async {
    // getRandom(10);
    return Response.ok(items);
  }

  @Operation.get('id')
  Future<Response> getThing(@Bind.path('id') int id) async {
    // getRandom(10);
    if (id < 0 || id >= items.length) {
      return Response.notFound();
    }
    return Response.ok(items[id]);
  }

  void getRandom(int num){
     Random random = new Random();
    for(int i=1; i<=num; i++){
      int item = random.nextInt(upper_bound-lower_bound+1) + lower_bound;
      if(!items.contains(item)){
        items.add(item);
      }else{
        i--;
      }
    }//end for
  }//close getRandom()
}