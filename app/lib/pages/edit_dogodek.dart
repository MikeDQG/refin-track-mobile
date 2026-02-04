import 'package:app/firebase/dogodek_service.dart';
import 'package:app/models/dogodek.dart';
import 'package:app/widgets/attribute_row.dart';
import 'package:app/widgets/card_button.dart';
import 'package:flutter/material.dart';

class EditDogodekPage extends StatefulWidget {
  final int stroj_id;

  EditDogodekPage({required this.stroj_id});

  @override
  State<EditDogodekPage> createState() => _EditDogodekPageState();
}

class _EditDogodekPageState extends State<EditDogodekPage> {
  late Dogodek dogodek;

  @override
  void initState() {
    super.initState();
    _initializeEditing();
  }

  Future<void> _initializeEditing() async {
    if (!mounted) return;

    setState(() {
      dogodek = Dogodek(
        id: "",
        naziv: "",
        datum: DateTime.now(),
        opis: "",
        stroj_id: widget.stroj_id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dodaj dogodek')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            EditableAttributeRow(
              attributeName: 'naziv',
              attributeValue: dogodek.naziv,
              isEditing: true,
              onChanged: (newValue) => dogodek.naziv = newValue,
            ),
            SizedBox(height: 16),
            EditableAttributeRow(
              attributeName: 'opis',
              attributeValue: dogodek.opis,
              isEditing: true,
              onChanged: (newValue) => dogodek.opis = newValue,
            ),
            SizedBox(height: 16),
            AttributeRow(
              attributeName: 'stroj_id',
              attributeValue: dogodek.displayDate(),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("aktiven:", style: TextStyle(fontSize: 16)),
                SizedBox(width: 8),
                IconButton(
                  onPressed: () => setState(() => dogodek.aktiven = true),
                  icon: Icon(
                    Icons.check_circle,
                    color: dogodek.aktiven ? Colors.green : Colors.grey,
                  ),
                ),
                Text(dogodek.aktiven ? 'DA' : 'NE'),
                IconButton(
                  onPressed: () => setState(() => dogodek.aktiven = false),
                  icon: Icon(
                    Icons.cancel,
                    color: !dogodek.aktiven ? Colors.red : Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text("datum:", style: TextStyle(fontSize: 16)),
                SizedBox(width: 8),
                Icon(Icons.calendar_today, size: 20),
                SizedBox(width: 8),
                TextButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        dogodek.datum = selectedDate;
                      });
                    }
                  },
                  child: Text('Select Date', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(width: 8),
                Text(dogodek.datum.toString()),
              ],
            ),
            SizedBox(height: 16),
            CardButton(
              title: "Shrani",
              onTap: () async {
                await FirebaseDogodekService.saveDogodek(dogodek: dogodek);
                Navigator.pop(context);
              },
              vertical: false,
              theme: Theme.of(context),
              height: 60,
              borderRadius: 8.0,
              icon: Icons.save,
              sizeFactor: 0.8,
            ),
          ],
        ),
      ),
    );
  }
}
