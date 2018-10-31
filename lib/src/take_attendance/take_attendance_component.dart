import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'dart:math';
import 'dart:html';

@Component(
  selector: 'take-attendance',
  styleUrls: ['take_attendance_component.css'],
  templateUrl: 'take_attendance_component.html',
  directives: [
    materialInputDirectives,
    NgFor,
    NgIf,
  ],
)
class TakeAttendanceComponent {
  String peoplenum = '1';
  String new_lower = '';
  String new_upper = '';
  int lower_bound = 10164507101;
  int upper_bound = 10164507150;
  static int num ;//number of people
  static bool flag_warn = false;
  static bool flag_modify = false;
  static bool flag_show = false;
  static bool flag_radio = true;
  static int flag_correct = 0;
  List<int> items = [];

  bool isEmpty(){
    if(peoplenum != '')
      return true;
    else
      return false;
  }

  bool isYes(){
    InputElement radio = querySelector("#sorted");
    if(radio.checked){
       return true;
    }
    else return false;
  }
  
  void getRandom(){
    Random random = new Random();
    for(int i=1; i<=num; i++){
      int item = random.nextInt(upper_bound-lower_bound+1) + lower_bound;
      if(!items.contains(item)){
        items.add(item);
      }else{
        i--;
      }
    }
    if(isYes()){
      items.sort();
    }
  }

  void judgeNum(){
    items = [];
    flag_warn = false;
    flag_show = false;
    flag_modify = false;
    try{
      num = int.parse(peoplenum);
    
      if(num> (upper_bound-lower_bound+1) || num<0)
        flag_warn = true;
      else{
        flag_warn=false;
        flag_show = true;
        getRandom();
      }
    }catch(error){
      flag_warn = true;
    }
  }

  void tryModify(){
    items = [];
    flag_warn=false; 
    flag_show=false;
    flag_modify=true;
  }

  void judgeNewBound(){
    if(new_upper =='' && new_lower=='') flag_correct = 5;
    else if(new_upper=='') flag_correct = 3;
    else if(new_lower=='') flag_correct = 4;
    else{
      int newl = int.parse(new_lower);
      int newu = int.parse(new_upper);
      if(newl==newu) flag_correct = 1;
      else if(newl>newu) flag_correct = 2;
      else{
        flag_correct = 0;
        lower_bound = newl;
        upper_bound = newu;
      }
    }
  }
}
  