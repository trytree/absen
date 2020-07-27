import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/cupertino.dart';

class ListPerHari extends StatefulWidget {
  ListPerHari(this.waktu, this.tanggal);
  String waktu;
  DateTime tanggal;
  @override
  _ListPerHariState createState() => _ListPerHariState();
}
final List<Data> datas = <Data>[];

final EmployeeDataSource _employeeDataSource = EmployeeDataSource();
class _ListPerHariState extends State<ListPerHari> {
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    datas.clear();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('data').where('waktu', isEqualTo: widget.waktu).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(
          child: const CupertinoActivityIndicator(),
        );
        for (int i = 0; i < snapshot.data.documents.length; i++) {
          var data = snapshot.data.documents[i];
          String id = snapshot.data.documents[i].documentID;
          datas.add(Data(
              id,
              data['santri'],
            data['ayat'][0],
            data['ayat'][1],
            data['surat'],
            data['nilai']
          ));
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Data per Hari'),
          ),
          body: SfDataGrid(
            source: _employeeDataSource,
            columnWidthMode: ColumnWidthMode.auto,
            columns: <GridColumn>[
              GridTextColumn(mappingName: 'nama', headerText: 'Nama'),
              GridTextColumn(mappingName: 'ayat', headerText: 'Ayat'),
              GridTextColumn(mappingName: 'surat', headerText: 'Surat'),
              GridTextColumn(mappingName: 'nilai', headerText: 'Nilai'),
            ],
          ),
        );
      }
    );
  }

}

class Data {
  Data(this.id, this.nama, this.ayatawal, this.ayatakhir, this.surat, this.nilai);
  final String id;
  final String nama;
  final int ayatawal;
  final int ayatakhir;
  final String surat;
  final String nilai;
}

class EmployeeDataSource extends DataGridSource {
  @override
  List<Object> get dataSource => datas;

  @override
  Object getCellValue(int rowIndex, String columnName) {
    switch (columnName) {
      case 'id':
        return datas[rowIndex].id;
        break;
      case 'nama':
        return datas[rowIndex].nama;
        break;
      case 'ayat':
        return datas[rowIndex].ayatawal.toString() + ' - ' + datas[rowIndex].ayatakhir.toString();
        break;
      case 'surat':
        return datas[rowIndex].surat;
        break;
        case 'nilai':
          switch(datas[rowIndex].nilai){
            case 'A': return 'sangat baik'; break;
            case 'B': return 'baik'; break;
            case 'C': return 'cukup'; break;
            case 'D': return 'kurang'; break;
          }
      break;
      default:
        return ' ';
        break;
    }
  }
}