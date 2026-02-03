import 'package:flutter/material.dart';

class AttributeRow extends StatelessWidget {
  final String attributeName;
  final String attributeValue;

  AttributeRow({required this.attributeName, required this.attributeValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("$attributeName:", style: TextStyle(fontSize: 16)),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            attributeValue,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class EditableAttributeRow extends AttributeRow {
  final String attributeName;
  final String attributeValue;
  final bool isEditing;
  final void Function(String newValue) onChanged;

  EditableAttributeRow({
    required this.attributeName,
    required this.attributeValue,
    required this.isEditing,
    required this.onChanged,
  }) : super(attributeName: attributeName, attributeValue: attributeValue);

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("$attributeName:", style: TextStyle(fontSize: 16)),
          SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              onChanged: onChanged,
              initialValue: attributeValue,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 8,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return super.build(context);
    }
  }
}
