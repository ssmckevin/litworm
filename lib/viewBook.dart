import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ViewBookPage extends StatefulWidget {
  final String docId;
  final Map<String, dynamic> data;

  const ViewBookPage({super.key, required this.docId, required this.data});

  @override
  State<ViewBookPage> createState() => _ViewBookPageState();
}

class _ViewBookPageState extends State<ViewBookPage> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _genreController; // Added
  late TextEditingController _yearController;  // Added
  late TextEditingController _chapterController;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing data from Firestore
    _titleController = TextEditingController(text: widget.data['title']);
    _authorController = TextEditingController(text: widget.data['author']);
    _genreController = TextEditingController(text: widget.data['genre'] ?? "General");
    _yearController = TextEditingController(text: widget.data['year']?.toString() ?? "2024");
    _chapterController = TextEditingController(text: widget.data['currentChapter']?.toString() ?? "1");
    _imageUrl = widget.data['imageUrl'];
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageUrl = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade500, // Matching mainBooks background
      appBar: AppBar(
        title: const Text("Edit Book"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              // Delete from Firestore
              FirebaseFirestore.instance.collection('books').doc(widget.docId).delete();
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.deepPurple.shade100,
                backgroundImage: _imageUrl != null ? FileImage(File(_imageUrl!)) : null,
                child: _imageUrl == null ? const Icon(Icons.add_a_photo, color: Colors.deepPurple) : null,
              ),
            ),
            const SizedBox(height: 24),

            // Title Field
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Book Title",
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),

            // Author Field
            TextField(
              controller: _authorController,
              decoration: const InputDecoration(
                labelText: "Author",
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),

            // Genre Field
            TextField(
              controller: _genreController,
              decoration: const InputDecoration(
                labelText: "Genre",
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),

            // Year and Chapter Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _yearController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Year Released",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _chapterController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Current Chapter",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Save Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurple,
              ),
              onPressed: () async {
                // Update the specific document in Firestore
                await FirebaseFirestore.instance.collection('books').doc(widget.docId).update({
                  'title': _titleController.text,
                  'author': _authorController.text,
                  'genre': _genreController.text,
                  'year': int.tryParse(_yearController.text) ?? 2024,
                  'currentChapter': int.tryParse(_chapterController.text) ?? 1,
                  'imageUrl': _imageUrl,
                });

                if (context.mounted) Navigator.pop(context);
              },
              child: const Text("Save Changes", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}