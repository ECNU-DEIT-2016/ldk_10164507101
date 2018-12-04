import 'dart:async';
import 'package:sqljocky5/sqljocky.dart';

var Goal = [];

/// Drops the tables if they already exist
Future<void> dropTables(MySqlConnection conn) async {
  print("Dropping tables ...");
  await conn.execute("DROP TABLE IF EXISTS student, course, sc");
  print("Dropped tables!");

}//close dropTables()


/*
 * Create the tables
 * table student(sid, sname, age, sex), course(cid, cname) 
 * and the table sc(sid, cid) about the Course Selection info.
 */
Future<void> createTables(MySqlConnection conn) async {
  print("Creating tables ...");
  await conn.execute('CREATE TABLE student (sid BIGINT NOT NULL, '
      'sname VARCHAR(255), '
      'age INTEGER, '
      'sex VARCHAR(4), '
      'PRIMARY KEY (sid))');//student
  await conn.execute('CREATE TABLE course (cid INTEGER NOT NULL, '
      'cname VARCHAR(255), '
      'PRIMARY KEY (cid))');//course
  await conn.execute('CREATE TABLE sc (sid BIGINT NOT NULL, '
      'cid INTEGER NOT NULL, '
      'FOREIGN KEY (sid) REFERENCES student (sid), '
      'FOREIGN KEY (cid) REFERENCES course (cid), '
      'PRIMARY KEY (sid, cid))');//sc

  print("Created table!\n");

}//close createTables()


//insert the information into the tables
Future<void> insertRows(MySqlConnection conn) async {
  print("Inserting rows ...");

  //student
  await conn.preparedMulti("INSERT INTO student (sid, sname, age, sex) VALUES (?, ?, ?, ?)", [
    [10164507101, "Shepherd", 20, "M"], [10164507102, "Betty", 18, "F"], [10164507103, "Linda", 20, "F"],
    [10164507104, "Charles", 21, "M"], [10164507105, "Josephine", 19, "F"], [10164507106, "Fiona", 17, "F"],
    [10164507107, "Elizabeth", 18, "F"], [10164507108, "Bob", 20, "M"], [10164507109, "Thomas", 18, "M"],
    [10164507110, "Judy", 17, "F"], [10164507111, "George", 20, "M"], [10164507112, "Scott", 21, "M"],
    [10164507113, "Sophia", 19, "F"], [10164507114, "Emily", 17, "F"], [10164507115, "Caroline", 18, "F"],
  ]);
  print("  --Table Student Inserted!");

  //course
  await conn.preparedMulti(
      "INSERT INTO course (cid, cname) VALUES (?, ?)", [
    [101, "Web App Design and Development "],[102, "Java OOP"],[103, "C++ Programming"],[104, "Game Design"],[105, "linear algebra"],
    [106, "probability theory"],[107, "English"],[108, "Learning Sciences"],[109, "Data Base"],[110, "Photography skills"],[111, "Data Structure"],
  ]);
  print("  --Table Course Inserted!");

  //sc
  await conn.preparedMulti(
      "INSERT INTO sc (sid, cid) VALUES (?, ?)", [
    [10164507101, 101],[10164507101, 102],[10164507101, 105],[10164507101, 109],[10164507102, 101],[10164507102, 109],[10164507102, 108],
    [10164507103, 101],[10164507103, 104],[10164507103, 105],[10164507104, 105],[10164507104, 107],[10164507104, 108],
    [10164507105, 107],[10164507105, 108],[10164507105, 101],[10164507105, 110], [10164507106, 101],[10164507106, 103],[10164507106, 107],
    [10164507107, 101],[10164507107, 110],[10164507107, 111],[10164507108, 111],[10164507108, 107],[10164507108, 108],
    [10164507109, 101],[10164507109, 104],[10164507109, 108],[10164507110, 110],[10164507110, 109],[10164507110, 105],
    [10164507111, 101],[10164507111, 107],[10164507111, 111],[10164507112, 101],[10164507112, 110],[10164507112, 107],
    [10164507113, 101],[10164507113, 105],[10164507113, 110],[10164507114, 109],[10164507114, 103],[10164507114, 101],
    [10164507115, 101],[10164507115, 104],[10164507115, 102],
  ]);
  print("  --Table SC Inserted!");

  print("Rows inserted!\n");

}//close insertRows()


//read the data (SELECT)
Future<void> readData(MySqlConnection conn) async {
  Results result =
      await conn.execute('SELECT stu.sid,sname '
          'FROM student stu,course,sc '
          'WHERE stu.sid = sc.sid AND sc.cid = course.cid AND course.cid=101');
  print(result);
  print(result.map((r) => r.byName('sname')));

}



/*-------------main---------------*/
main() async {
  var s = ConnectionSettings(
    user: "root",
    password: "hello",
    host: "localhost",
    port: 3306,
    db: "students",
  );

  // create a connection
  print("Opening connection ...");
  var conn = await MySqlConnection.connect(s);
  print("Opened connection!");

  await dropTables(conn);
  await createTables(conn);
  await insertRows(conn);
  await readData(conn);

  await conn.close();

}
  