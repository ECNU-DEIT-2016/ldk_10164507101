import 'my_server.dart';
import 'dart:math';

var students = [];
var randoms = [];

//read the data (SELECT)
Future<void> readData(MySqlConnection conn, [courseid]) async {
  Results result;
  if(courseid != null)
  result =
      await conn.prepared('SELECT stu.sid,sname '
          'FROM student stu,course,sc '
          'WHERE stu.sid = sc.sid AND sc.cid = course.cid AND course.cid=(?)', [courseid]);
  else
  result =
      await conn.execute('SELECT sid, sname '
          'FROM student');

  result.forEach( (f) => students.add(f.toString()) );//store in students

}//close readData()


//call the readData to get data
Future<void> getData([courseid]) async{
  students = [];
  MySqlConnection conn = await connectDB();
  await readData(conn, courseid);
  await conn.close();

}//close getData()


//connect the DataBase return a conn
Future connectDB() async{
  var s = ConnectionSettings(
    user: "root",
    password: "hello",
    host: "localhost",
    port: 3306,
    db: "students",
  );

  var conn = await MySqlConnection.connect(s);
  return conn;

}//close connectDB()


Future<bool> noSuchCourse(courseid) async{
  MySqlConnection conn = await connectDB();
  Results result =
      await conn.prepared('SELECT cname '
          'FROM course '
          'WHERE course.cid=(?)', [courseid]);
  
  await conn.close();
  if(result.isEmpty) return true;
  else return false;

}//close noSuchCourse()


//get the random ones from students
void getRandom(int number){
  randoms = [];
  if(number > students.length){
    number = students.length;
  }else if(number <= 0){
    number = 1;
  }
  int size = students.length;
  Random rand = new Random();
  for(int i=1; i<=number; i++){
    int item = rand.nextInt(size);
    if(!randoms.contains(students[item])){
       randoms.add(students[item]);
    }else{
       i--;
    }
  }//end for()
  randoms.sort();
}


/*-------------------------Classes--------------------------*/

class MyServerChannel extends ApplicationChannel {

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router
      ..route("/students/[:courseid]").link(()=>StuController())
      ..route("/random").link(()=>RandController())
      ;

    return router;
  }//close Controller

}//close MyServerChannel()


//StuController -> /students/[:courseid]
class StuController extends ResourceController {

  @Operation.get()
  Future<Response> getStudents() async {
    await getData();
    return Response.ok(students);
  }

  @Operation.get('courseid')
  Future<Response> getStudent(@Bind.path('courseid') int courseid) async {
    if(await noSuchCourse(courseid)){
      return Response.notFound();
    }
    await getData(courseid);
    return Response.ok(students);
  }

}//close StuController()


//RandController -> /random/[:courseid]/[:number]
class RandController extends ResourceController {

  @Operation.get()
  Future<Response> getRandoms(@Bind.query('course') int course,
                              @Bind.query('number') int number) async {
    if(await noSuchCourse(course)){
      return Response.notFound();
    }
    await getData(course);
    getRandom(number);       
    return Response.ok(randoms);
  }

}//close StuController()