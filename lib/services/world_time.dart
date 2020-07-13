import 'package:intl/intl.dart';
import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  String location; //location for the UI
  String time; // the time in that location
  String flag; // url to an asset location
  String url; //location url for api endpoint
  bool isDayTime; // true or false if daytime or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      //make a request
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      // print(data);

      //get properties from data
      String datetime = data['utc_datetime'];
      String offset_hrs = data['utc_offset'].substring(1, 3);
      String offset_min = data['utc_offset'].substring(4, 6);

      // print(datetime);
      // print(offset);

      //create Datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(
          hours: int.parse(offset_hrs), minutes: int.parse(offset_min)));

      // set the time property
      // time = now.toString();
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = 'could not find time data!!!';
    }
  }
}

// WorldTime instance =
//     WorldTime(location: 'Berlin', flag: 'germany.ong', url: 'Europe/Berlin');
// instance.getTime();
