import 'package:app/firebase/dogodek_service.dart';
import 'package:app/firebase/stroj_service.dart';
import 'package:app/models/dogodek.dart';
import 'package:app/models/stroj.dart';
import 'package:app/pages/edit_dogodek.dart';
import 'package:app/widgets/attribute_row.dart';
import 'package:app/widgets/card_button.dart';
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
  bool isLoading = true;
  List<Dogodek> dogodki = [];

  @override
  void initState() {
    super.initState();
    _initializeEditing();
  }

  Future<void> _initializeEditing() async {
    final existingStroj = await FirebaseStrojService.getStrojById(
      widget.stroj.id,
    );
    final List<Dogodek> existingDogodki =
        await FirebaseDogodekService.getDogodkiByStroj(widget.stroj.id);

    if (!mounted) return;

    setState(() {
      print(existingDogodki);
      if (existingStroj == null) {
        isNewRecord = true;
        isEditing = true;
      } else {
        widget.stroj.naziv = existingStroj.naziv;
        widget.stroj.opis = existingStroj.opis;
      }
      print("widget.stroj.opis: ${widget.stroj.opis} - ${existingStroj?.opis}");
      isLoading = false;
      dogodki = existingDogodki;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Podrobnosti')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EditableAttributeRow(
                        attributeName: 'Naziv',
                        attributeValue: widget.stroj.naziv,
                        isEditing: isEditing,
                        onChanged: (value) => setState(() {
                          widget.stroj.naziv = value;
                        }),
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
                          if (isEditing) ...{
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (isNewRecord && isEditing) {
                                    Navigator.pop(context);
                                  } else {
                                    isEditing = !isEditing;
                                  }
                                });
                              },
                              child: Row(
                                children: [
                                  if (isEditing) ...{
                                    Text('Prekliči'),
                                    SizedBox(width: 8),
                                    Icon(Icons.close),
                                  } else ...{
                                    Text('Uredi'),
                                    SizedBox(width: 8),
                                    Icon(Icons.edit),
                                  },
                                ],
                              ),
                            ),
                          },
                          if (!isEditing) ...{
                            SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () async {
                                await FirebaseStrojService.deleteStroj(
                                  widget.stroj.id,
                                );
                                Navigator.pop(context);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Izbriši stroj',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.delete, color: Colors.red),
                                ],
                              ),
                            ),
                          },
                          if (isEditing) ...{
                            SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () async {
                                final Stroj editedStroj = Stroj(
                                  id: widget.stroj.id,
                                  naziv: widget.stroj.naziv,
                                  opis: widget.stroj.opis,
                                );
                                final int result = isNewRecord
                                    ? await FirebaseStrojService.saveStroj(
                                        stroj: editedStroj,
                                      )
                                    : await FirebaseStrojService.updateStroj(
                                        stroj: editedStroj,
                                      );
                                print('Saved stroj: $result');
                                setState(() {
                                  isEditing = !isEditing;
                                  isNewRecord = false;
                                });
                              },
                              child: Row(
                                children: [
                                  Text('Shrani'),
                                  SizedBox(width: 8),
                                  Icon(Icons.save),
                                ],
                              ),
                            ),
                          },
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CardButton(
                              title: "Dokumenti",
                              onTap: () {
                                // Navigate to another page or perform an action
                              },
                              theme: Theme.of(context),
                              height: 100,
                              borderRadius: 8.0,
                              sizeFactor: 0.8,
                              icon: Icons.description,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: CardButton(
                              title: "Kontakti",
                              onTap: () {
                                // Navigate to another page or perform an action
                              },
                              theme: Theme.of(context),
                              height: 100,
                              borderRadius: 8.0,
                              icon: Icons.contacts,
                              sizeFactor: 0.8,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Text(
                          'Dogodki',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          if (dogodki.isEmpty)
                            Text(
                              'Ni dogodkov za ta stroj.',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          if (dogodki.isNotEmpty) ...{
                            ...dogodki.map(
                              (d) => ListTile(
                                key: ValueKey(d.id),
                                title: Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsetsGeometry.all(8),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 8),
                                        Text(
                                          d.naziv,
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          d.displayDate(),
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () => {},
                              ),
                            ),
                          },
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EditDogodekPage(stroj_id: widget.stroj.id),
            ),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
