## 1.0.0

- Initial version, created by Stagehand

## My Server With DB
- 完成情况：端口：8002 

- 路由: 	localhost:8002/students 显示数据库内的所有学生信息(学号 + 名字)

        localhost:8002/students/[:courseid] 显示选修某课程的所有学生信息(学号 + 名字) 
        									数据库内的课程的课程号范围是101 - 111, 访问不存在的课程号会响应404 Not Found

        localhost:8002/random?course=<course>&number=<number> 查询字符串一个参数是course 课程号，一个是number，所需要的
        									随机数的个数，即返回修学某课程的number个随机的学生(学号 + 名字)，如果所需要的
        									随机数超过该课的学生人数上限，会修正为学生上限，如果number小于等于0，会修正为1

- 文件调用逻辑：Step 1 手动调用../database下的db.dart,以root链接数据库localhost:3306的数据库students，建立三张表：studnt(学生信息)
					  , course(课程信息), sc(包含学号与对应课程号的选课信息)
			   Step 2 手动调用../my_server/bin下的main.dart,创建服务器

- 函数解释：(channel.dart中的) 
           - connectDB() 链接数据库，并返回conn 便于在必要时候关闭链接
           - getData() 链接数据库，调用readData() 将数据存在全局的students数组内，最后关闭链接
           - readData() 根据可选参数courseid的情况: 没有输入courseid，即courseid=null，调用SQL，获取所有学生
           										  输入courseid，获取选修该课程的所有学生信息。
           - noSuchCourse() 根据courseid， 用sql判断该课程是否在course表中存在
           - getRandom() 根据number，生成随机数，选取随机数数量的学生存入全局数组randoms

- 建表SQL：student：
		CREATE TABLE student (sid BIGINT NOT NULL, 
								sname VARCHAR(255), 
      							age INTEGER, 
      							sex VARCHAR(4), 
      							PRIMARY KEY (sid));
		 INSERT INTO student (sid, sname, age, sex) VALUES (10164507101, "Shepherd", 20, "M");
		 INSERT INTO student (sid, sname, age, sex) VALUES (10164507102, "Betty", 18, "F");
		 INSERT INTO student (sid, sname, age, sex) VALUES (10164507103, "Linda", 20, "F");
		 INSERT INTO student (sid, sname, age, sex) VALUES (10164507104, "Charles", 21, "M");
		 INSERT INTO student (sid, sname, age, sex) VALUES (10164507105, "Josephine", 19, "F");
		 INSERT INTO student (sid, sname, age, sex) VALUES (10164507106, "Fiona", 17, "F");
		 INSERT INTO student (sid, sname, age, sex) VALUES (10164507107, "Elizabeth", 18, "F");
		 INSERT INTO student (sid, sname, age, sex) VALUES (10164507108, "Bob", 20, "M");
		 INSERT INTO student (sid, sname, age, sex) VALUES (10164507109, "Thomas", 18, "M");
		 INSERT INTO student (sid, sname, age, sex) VALUES (10164507110, "Judy", 17, "F");
		 INSERT INTO student (sid, sname, age, sex) VALUES (10164507111, "George", 20, "M");
		 INSERT INTO student (sid, sname, age, sex) VALUES (10164507112, "Scott", 21, "M");
		 INSERT INTO student (sid, sname, age, sex) VALUES (10164507113, "Sophia", 19, "F");
		 INSERT INTO student (sid, sname, age, sex) VALUES (10164507114, "Emily", 17, "F");
		 INSERT INTO student (sid, sname, age, sex) VALUES (10164507115, "Caroline", 18, "F");

		course：
		CREATE TABLE course (cid INTEGER NOT NULL, 
     							cname VARCHAR(255), 
      							PRIMARY KEY (cid));
      	INSERT INTO course (cid, cname) VALUES (101, "Web App Design and Development ");
      	INSERT INTO course (cid, cname) VALUES (102, "Java OOP" );
      	INSERT INTO course (cid, cname) VALUES (103, "C++ Programming" );
      	INSERT INTO course (cid, cname) VALUES (104, "Game Design" );
      	INSERT INTO course (cid, cname) VALUES (105, "linear algebra" );
      	INSERT INTO course (cid, cname) VALUES (106, "probability theory" );
      	INSERT INTO course (cid, cname) VALUES (107, "English" );
      	INSERT INTO course (cid, cname) VALUES (108, "Learning Sciences" );
      	INSERT INTO course (cid, cname) VALUES (109, "Data Base" );
      	INSERT INTO course (cid, cname) VALUES (110, "Photography skills" );
      	INSERT INTO course (cid, cname) VALUES (111, "Data Structure" );

      	sc：
      	CREATE TABLE sc (sid BIGINT NOT NULL, 
     					 cid INTEGER NOT NULL, 
     					 FOREIGN KEY (sid) REFERENCES student (sid), 
     					 FOREIGN KEY (cid) REFERENCES course (cid), 
     					 PRIMARY KEY (sid, cid));
     	INSERT INTO sc (sid, cid) VALUES (10164507101, 101);
     	INSERT INTO sc (sid, cid) VALUES (10164507101, 102);
     	INSERT INTO sc (sid, cid) VALUES (10164507101, 105);
     	INSERT INTO sc (sid, cid) VALUES (10164507101, 109);
     	INSERT INTO sc (sid, cid) VALUES (10164507102, 101);
     	INSERT INTO sc (sid, cid) VALUES (10164507102, 109);
     	INSERT INTO sc (sid, cid) VALUES (10164507102, 108);
     	INSERT INTO sc (sid, cid) VALUES (10164507103, 101);
     	INSERT INTO sc (sid, cid) VALUES (10164507103, 104);
     	INSERT INTO sc (sid, cid) VALUES (10164507103, 105);
     	INSERT INTO sc (sid, cid) VALUES (10164507104, 105);
     	INSERT INTO sc (sid, cid) VALUES (10164507104, 107);
     	INSERT INTO sc (sid, cid) VALUES (10164507104, 108);
     	INSERT INTO sc (sid, cid) VALUES (10164507105, 107);
     	INSERT INTO sc (sid, cid) VALUES (10164507105, 108);
     	INSERT INTO sc (sid, cid) VALUES (10164507105, 101);
     	INSERT INTO sc (sid, cid) VALUES (10164507105, 110);
     	INSERT INTO sc (sid, cid) VALUES (10164507106, 101);
     	INSERT INTO sc (sid, cid) VALUES (10164507106, 103);
     	INSERT INTO sc (sid, cid) VALUES (10164507106, 107);
     	INSERT INTO sc (sid, cid) VALUES (10164507107, 101);
     	INSERT INTO sc (sid, cid) VALUES (10164507107, 110);
     	INSERT INTO sc (sid, cid) VALUES (10164507107, 111);
     	INSERT INTO sc (sid, cid) VALUES (10164507108, 111);
     	INSERT INTO sc (sid, cid) VALUES (10164507108, 107);
     	INSERT INTO sc (sid, cid) VALUES (10164507108, 108);
     	INSERT INTO sc (sid, cid) VALUES (10164507109, 101);
     	INSERT INTO sc (sid, cid) VALUES (10164507109, 104);
     	INSERT INTO sc (sid, cid) VALUES (10164507109, 108);
     	INSERT INTO sc (sid, cid) VALUES (10164507110, 110);
     	INSERT INTO sc (sid, cid) VALUES (10164507110, 109);
     	INSERT INTO sc (sid, cid) VALUES (10164507110, 105);
     	INSERT INTO sc (sid, cid) VALUES (10164507111, 101);
     	INSERT INTO sc (sid, cid) VALUES (10164507111, 107);
     	INSERT INTO sc (sid, cid) VALUES (10164507111, 111);
     	INSERT INTO sc (sid, cid) VALUES (10164507112, 101);
     	INSERT INTO sc (sid, cid) VALUES (10164507112, 110);
     	INSERT INTO sc (sid, cid) VALUES (10164507112, 107);
     	INSERT INTO sc (sid, cid) VALUES (10164507113, 101);
     	INSERT INTO sc (sid, cid) VALUES (10164507113, 105);
     	INSERT INTO sc (sid, cid) VALUES (10164507113, 110);
     	INSERT INTO sc (sid, cid) VALUES (10164507114, 109);
     	INSERT INTO sc (sid, cid) VALUES (10164507114, 103);
     	INSERT INTO sc (sid, cid) VALUES (10164507114, 101);
     	INSERT INTO sc (sid, cid) VALUES (10164507115, 101);
     	INSERT INTO sc (sid, cid) VALUES (10164507115, 104);
     	INSERT INTO sc (sid, cid) VALUES (10164507115, 102);