import 'package:flutter/material.dart';
import '../models/expense_model.dart';

class AddEditView extends StatefulWidget {
  final Journal? journal;

  const AddEditView({super.key, this.journal});

  @override
  State<AddEditView> createState() => _AddEditViewState();
}

class _AddEditViewState extends State<AddEditView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _noteController;
  late TextEditingController _moodController;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.journal?.note ?? "");
    _moodController = TextEditingController(text: widget.journal?.mood ?? "");
    _selectedDate = widget.journal != null
        ? DateTime.tryParse(widget.journal!.date) ?? DateTime.now()
        : DateTime.now();
  }

  @override
  void dispose() {
    _noteController.dispose();
    _moodController.dispose();
    super.dispose();
  }

  void _saveJournal() {
    if (_formKey.currentState!.validate()) {
      final newJournal = Journal(
        id: widget.journal?.id ?? "",
        note: _noteController.text,
        mood: _moodController.text,
        date: _selectedDate.toLocal().toString().split(' ')[0],
      );

      Navigator.pop(context, newJournal);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.journal == null ? "Add Journal" : "Edit Journal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: "Note"),
                validator: (val) =>
                    val == null || val.isEmpty ? "Enter note" : null,
              ),
              TextFormField(
                controller: _moodController,
                decoration: const InputDecoration(labelText: "Mood"),
                validator: (val) =>
                    val == null || val.isEmpty ? "Enter mood" : null,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Date: ${_selectedDate.toLocal().toString().split(' ')[0]}",
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: const Text("Select Date"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveJournal,
                child: Text(widget.journal == null ? "Add" : "Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
