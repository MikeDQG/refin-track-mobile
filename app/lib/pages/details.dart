import 'package:app/firebase/save_stroj.dart';
import 'package:app/models/stroj.dart';
import 'package:app/widgets/attribute_row.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final Stroj stroj;

  DetailsPage({required this.stroj});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isEditing = false;
  bool isNewRecord = false;

  @override
  void initState() {
    super.initState();
    _initializeEditing();
  }

  Future<void> _initializeEditing() async {
    isNewRecord =
        await FirebaseStrojService.getStrojById(widget.stroj.id) == null;
    isEditing = isNewRecord;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Podrobnosti')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditableAttributeRow(
              attributeName: 'Naziv',
              attributeValue: widget.stroj.naziv,
              isEditing: isEditing,
              onChanged: (value) => widget.stroj.naziv = value,
            ),
            SizedBox(height: 8),
            AttributeRow(
              attributeName: 'Številka',
              attributeValue: widget.stroj.id.toString(),
            ),
            SizedBox(height: 8),
            EditableAttributeRow(
              attributeName: 'Opis',
              isEditing: isEditing,
              attributeValue: widget.stroj.opis ?? "/",
              onChanged: (newValue) => widget.stroj.opis = newValue,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isNewRecord)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isEditing = !isEditing;
                      });
                    },
                    child: Text(isEditing ? 'Prekliči urejanje' : 'Uredi'),
                  ),
                if (isEditing && !isNewRecord) SizedBox(width: 16),
                if (isEditing)
                  ElevatedButton(
                    onPressed: () async {
                      final Stroj editedStroj = Stroj(
                        id: widget.stroj.id,
                        naziv: widget.stroj.naziv,
                        opis: widget.stroj.opis,
                      );
                      final int _result = isNewRecord
                          ? await FirebaseStrojService.saveStroj(
                              stroj: editedStroj,
                            )
                          : await FirebaseStrojService.updateStroj(
                              stroj: editedStroj,
                            );
                      print('Saved stroj: $_result');
                      setState(() {
                        isEditing = !isEditing;
                        isNewRecord = false;
                      });
                    },
                    child: Text('Shrani'),
                  ),
              ],
            ),
            Divider(),
            ElevatedButton(
              onPressed: () async {
                await FirebaseStrojService.saveStroj(stroj: widget.stroj);
              },
              child: Text('save stroj'),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseStrojService.getAllStroji();
              },
              child: Text('get all stroj'),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseStrojService.getStrojById(widget.stroj.id);
              },
              child: Text('get stroj by id - 1'),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseStrojService.deleteStroj(widget.stroj.id);
              },
              child: Text('Izbriši stroj'),
            ),
          ],
        ),
      ),
    );
  }
}
