import 'package:absen/screen/listPerHari.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'listPerHari.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Kalender extends StatefulWidget {
  @override
  _KalenderState createState() => _KalenderState();
}
class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay, this.id);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String id;

}

class _KalenderState extends State<Kalender> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('data').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(
          child: const CupertinoActivityIndicator(),
        );
        List<Meeting> meet = List();
        for (int i = 0; i < snapshot.data.documents.length; i++) {
          var data = snapshot.data.documents[i];
          String id = snapshot.data.documents[i].documentID;
          meet.add(Meeting(
              data['waktu'],
              DateTime.parse(data['tanggal'].toDate().toString()),
              DateTime.parse(data['tanggal'].toDate().toString()),
              const Color(0xFF0F8644), true, id
          ));
        }
        return Scaffold(
          body: SafeArea(
            child: Container(
              child: SfCalendar(
                view: CalendarView.schedule,
                dataSource: MeetingDataSource(meet),
                monthViewSettings: MonthViewSettings(appointmentDisplayCount: 2,showAgenda: true),
                onTap: (CalendarTapDetails details) {
                  if(details.appointments != null){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ListPerHari(details.appointments[0].eventName, details.appointments[0].from),
                    ));
                  } else{return null;}
                },
              ),
            ),
          ),
        );
      }
    );
  }

}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

