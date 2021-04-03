import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:test1/home/info_card.dart';

class course extends StatefulWidget {
  @override
  _CourseState createState() => _CourseState();
}

class _CourseState extends State<course> {
  //从后台返回的数据结果
  List data = [];
  /*
   {
    "status": "success",
    "data": {
        "result": [
            {
                "_id": "33bbcf40-90ec-11eb-b411-a769399ffcf7",
                "course_id": {
                    "_id": "4f9d69d0-8246-11eb-bcc8-751424e2529d",
                    "name": "项目开发实训",
                    "id": "4f9d69d0-8246-11eb-bcc8-751424e2529d"
                },
                "lesson_id": "0cf386a0-90ec-11eb-b411-a769399ffcf7",
                "teacher_id": {
                    "_id": "bf06cba2-8245-11eb-bcc8-751424e2529d",
                    "name": "田 丰",
                    "id": "bf06cba2-8245-11eb-bcc8-751424e2529d"
                },
                "curriculum": [
                    {
                        "order": [
                            "1",
                            "2"
                        ],
                        "odd_or_even": 0,
                        "class_id": {
                            "class_name": "小鸡快跑",
                            "id": null
                        },
                        "room_id": {
                            "room_name": "报告厅",
                            "room_size": 0,
                            "room_status": "avaliable",
                            "_id": "294ddf50-8325-11eb-83e1-7f120a53dbef",
                            "room_number": 1354,
                            "room_type": "办公室",
                            "building_name": "文津楼",
                            "campus_name": "长安校区",
                            "org_name": "陕西师范大学",
                            "room_users": [],
                            "__v": 0,
                            "living_lessonID": null,
                            "deviceBoxIP": "192.168.188.217"
                        },
                        "date": "Tue"
                    }
                ],
                "__v": 0,
                "semester": 1,
                "year": "2021-2022"
            }
        ]
     }
   }
   */
  Map course_id = new Map();
  /*
  "course_id": {
                    "_id": "4f9d69d0-8246-11eb-bcc8-751424e2529d",
                    "name": "项目开发实训",
                    "id": "4f9d69d0-8246-11eb-bcc8-751424e2529d"
                },
  */

  Map teacher_id = new Map();
  /*
   "teacher_id": {
                    "_id": "bf06cba2-8245-11eb-bcc8-751424e2529d",
                    "name": "田 丰",
                    "id": "bf06cba2-8245-11eb-bcc8-751424e2529d"
                },
  */

  List curriculum = [];

  /*
   "curriculum": [
                    {
                        "order": [
                            "1",
                            "2"
                        ],
                        "odd_or_even": 0,
                        "class_id": {
                            "class_name": "小鸡快跑",
                            "id": null
                        },
                        "room_id": {
                            "room_name": "报告厅",
                            "room_size": 0,
                            "room_status": "avaliable",
                            "_id": "294ddf50-8325-11eb-83e1-7f120a53dbef",
                            "room_number": 1354,
                            "room_type": "办公室",
                            "building_name": "文津楼",
                            "campus_name": "长安校区",
                            "org_name": "陕西师范大学",
                            "room_users": [],
                            "__v": 0,
                            "living_lessonID": null,
                            "deviceBoxIP": "192.168.188.217"
                        },
                        "date": "Tue"
                    }
                ],
   */
  //学期
  int semester;
  //学年
  String year;

  @override
  void initState() {
    super.initState();
    _getCourse();
  }

  _getCourse() async {
    //取出保存在shardPreferences的用户ID值，作为接口访问参数
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      var getCourseUrl =
          "http://10.8.51.45:3050/api/pc/v1/timetables/getTimeTableFromStudentID";
      Dio dio = new Dio();
      Response response = await dio.post(getCourseUrl, data: {
        "student_id": sharedPreferences.getString("id"),
        "year": "2020-2021",
        "semester": 1
      });
      //"student_id":b8d49300-8247-11eb-bcc8-751424e2529d
      if (response.statusCode == 200) {
        setState(() {
          this.data = response.data['data']['result'];
          //print(result);
          // print(result[0]['course_id']);
          this.course_id = data[0]['course_id'];
          this.teacher_id = data[0]['teacher_id'];
          this.curriculum = data[0]['curriculum'];
          this.semester = data[0]["semester"];
          this.year = data[0]["year"];
        });
      } else {
        print("请求失败");
      }
    } catch (exception) {
      print('ecx:$exception');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("course"),
        ),
        body: SafeArea(
            minimum: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Text(
                  '课程：${course_id['name']}',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.right,
                ),
                Text(
                  '教师：${teacher_id['name']}',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.left,
                ),
                curriculum.isEmpty == false
                    ? Text(
                        '${curriculum[0]['room_id']['campus_name']}${curriculum[0]['room_id']['building_name']}${curriculum[0]['room_id']['room_number']}',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.left,
                      )
                    : Text('未知')
              ],
            )));
  }
}
