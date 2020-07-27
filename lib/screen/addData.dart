import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import '../data.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}
class Santri {
  String id;
  String nama;
  String kamar;

  Santri(this.id, this.nama, this.kamar);

}
class _AddDataState extends State<AddData> {
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Santri>> key = new GlobalKey();
  String idsantri, surat, ayatawal, ayatakhir, waktu, nilai, catatan;
  bool accept = false;


  final ValueChanged _onChanged = (val) => print(val);

  @override
  Widget build(BuildContext context) {
    print(getDataSantri());
    Widget row(Santri user) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            user.nama,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            user.kamar,
          ),
        ],
      );
    }
    return
      new StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('santri').snapshots(),
          builder: (context, snapshot){
            if (!snapshot.hasData) return const Center(
              child: const CupertinoActivityIndicator(),
            );
            List<Santri> santri = List();
            for (int i = 0; i < snapshot.data.documents.length; i++) {
              data = snapshot.data.documents[i];
              String id = snapshot.data.documents[i].documentID;
              santri.add(Santri(id, data['nama'], data['kamar']));
            }
            return new Scaffold(
              appBar: AppBar(
                title: Text('Tambah Data'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    FormBuilder(
                      // context,
                      key: _fbKey,
                      // autovalidate: true,
                      readOnly: false,
                      child: Column(
                        children: <Widget>[
                          searchTextField = AutoCompleteTextField<Santri>(
                            key: key,
                            clearOnSubmit: false,
                            suggestions: santri,
                            style: TextStyle(color: Colors.black, fontSize: 16.0),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              hintText: "Search Name",
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                            itemFilter: (item, query) {
                              return item.nama
                                  .toLowerCase()
                                  .startsWith(query.toLowerCase());
                            },
                            itemSorter: (a, b) {
                              return a.nama.compareTo(b.nama);
                            },
                            itemSubmitted: (item) {
                              setState(() {
                                searchTextField.textField.controller.text = item.nama;
                                idsantri = item.id;
                                print(item.id);
                              });
                            },
                            itemBuilder: (context, item) {
                              // ui for the autocomplete row
                              return row(item);
                            },
                          ),
                          FormBuilderDropdown(
                            attribute: "surat",
                            decoration: InputDecoration(labelText: "Surat"),
                            // initialValue: 'Male',
                            onChanged: (item) {
                              setState(() {
                                surat = item;
                              });
                            },
                            hint: Text('Pilih Surat'),
                            validators: [FormBuilderValidators.required()],
                            items: allsurat
                                .map((surat) => DropdownMenuItem(
                              value: surat,
                              child: Text('$surat'),
                            ))
                                .toList(),
                          ),
                              FormBuilderTextField(
                                attribute: 'ayatawal',
                                decoration: const InputDecoration(
                                  labelText: 'Ayat Awal',
                                ),
                                onChanged: (item) {
                                  setState(() {
                                    ayatawal = item;
                                  });
                                },
                                valueTransformer: (text) {
                                  return text == null ? null : num.tryParse(text);
                                },
                                validators: [
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.numeric(),
                                  // FormBuilderValidators.max(70),
                                  FormBuilderValidators.minLength(1)
                                ],
                                keyboardType: TextInputType.number,
                              ),FormBuilderTextField(
                                attribute: 'Ayat Akhir',
                                decoration: const InputDecoration(
                                  labelText: 'Ayat',
                                ),
                                onChanged: (item) {
                                  setState(() {
                                    ayatakhir = item;
                                  });
                                },
                                valueTransformer: (text) {
                                  return text == null ? null : num.tryParse(text);
                                },
                                validators: [
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.numeric(),
                                  // FormBuilderValidators.max(70),
                                  FormBuilderValidators.minLength(1)
                                ],
                                keyboardType: TextInputType.number,
                              )
                          ,
                          FormBuilderDropdown(
                            attribute: 'waktu',
                            decoration: const InputDecoration(
                              labelText: 'Waktu',
                            ),
                            // initialValue: 'Male',
                            hint: Text('Pilih waktu'),
                            validators: [FormBuilderValidators.required()],
                            items: [
                              DropdownMenuItem(
                                value: 'maghrib',
                                child: Text("Ba'da Maghrib"),
                              ),
                              DropdownMenuItem(
                                value: 'subuh',
                                child: Text("Ba'da Shubuh"),
                              )
                            ],
                            // isExpanded: false,
                            allowClear: true,
                            onChanged: (option) =>setState(()=>waktu = option)
                          ),
                          FormBuilderDropdown(
                            attribute: 'nilai',
                            decoration: const InputDecoration(
                              labelText: 'Nilai',
                            ),
                            // initialValue: 'Male',
                            hint: Text('Pilih nilai'),
                            validators: [FormBuilderValidators.required()],
                            items: [
                              DropdownMenuItem(
                                value: 'A',
                                child: Text("Sangat Baik"),
                              ),
                              DropdownMenuItem(
                                value: 'B',
                                child: Text("Baik"),
                              ),
                              DropdownMenuItem(
                                value: 'C',
                                child: Text("Cukup"),
                              ),
                              DropdownMenuItem(
                                value: 'D',
                                child: Text("Kurang"),
                              )
                            ],
                            // isExpanded: false,
                            allowClear: true,
                              onChanged: (option) =>setState(()=>nilai = option)
                          ),
                          FormBuilderTextField(
                            attribute: 'catatan',
                            decoration: const InputDecoration(
                              labelText:
                              'Catatan (Bila Perlu)',
                            ),
                            onChanged: (option) =>setState(()=>catatan = option),
                            valueTransformer: (text) {
                              return text == null ? null : num.tryParse(text);
                            },
                            validators: [
                            ],
                          ),
                          SizedBox(height: 15),
                          FormBuilderCheckbox(
                            attribute: 'accept_terms',
                            initialValue: false,
                            onChanged: (item) {
                    setState(() {
                    accept = !accept;
                    });
                    },
                            leadingInput: true,
                            label: Text('Data telah di cek dengan benar'),
                            validators: [
                              FormBuilderValidators.requiredTrue(
                                errorText:
                                'You must accept terms and conditions to continue',
                              ),
                            ],
                          ),
                          SizedBox(width: 20),



                          MaterialButton(
                            color: Theme.of(context).accentColor,
                            child: Text(
                              'TAMBAH',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if(accept){
                                print(waktu);
                                Firestore.instance.collection("data")
                                    .add({
                                  'tanggal': FieldValue.serverTimestamp(),
                                  'santri': searchTextField.textField.controller.text,
                                  'idsantri': idsantri,
                                  'surat': surat,
                                  'ayat': [int.parse(ayatawal), int.parse(ayatakhir)],
                                  'waktu': waktu,
                                  'nilai': nilai,
                                  'catatan': catatan != null ? catatan : 'kosong'
                                }).then((value) => print(value.documentID));

                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
      );

  }
}
