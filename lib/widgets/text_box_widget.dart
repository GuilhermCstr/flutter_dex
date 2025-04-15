import 'package:flutter/material.dart';

class TextBoxWidget extends StatefulWidget {
  final Function(String) onFilterChanged;

  const TextBoxWidget({super.key, required this.onFilterChanged});

  @override
  State<TextBoxWidget> createState() => _TextBoxWidgetState();
}

class _TextBoxWidgetState extends State<TextBoxWidget> {
  final TextEditingController _filterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filterController.addListener(_onFilterTextChanged);
  }

  @override
  void dispose() {
    _filterController.removeListener(_onFilterTextChanged);
    _filterController.dispose();
    super.dispose();
  }

  void _onFilterTextChanged() {
    widget.onFilterChanged(_filterController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          controller: _filterController,
          decoration: InputDecoration(
            hintText: 'Name or number',
            hintStyle: TextStyle(color: Colors.grey[600]),
            prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          ),
          style: TextStyle(color: Colors.black),
        ));
  }
}
